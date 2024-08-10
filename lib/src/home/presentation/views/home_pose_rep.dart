import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gainz_ai_app/src/home/domain/entities/dailyworkout.dart';
import 'package:gainz_ai_app/src/home/presentation/views/home_save_reps.screen.dart';
import 'package:google_mlkit_pose_detection/google_mlkit_pose_detection.dart';

class HomePoseRepScreen extends StatefulWidget {
  HomePoseRepScreen({required this.dailyWorkout, super.key});

  DailyWorkout? dailyWorkout;

  static const routeName = '/home-pose-rep';

  @override
  State<HomePoseRepScreen> createState() => _HomePoseRepScreenState();
}

class _HomePoseRepScreenState extends State<HomePoseRepScreen> {
  late CameraController _controller;
  late PoseDetector _poseDetector;
  bool _isDetecting = false;
  int _jumpingJackCount = 0;
  bool _isArmsUp = false;
  bool _cameraInitialized = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _jumpingJackCount = 0;
    _initializeCamera();
    _poseDetector = PoseDetector(options: PoseDetectorOptions());
  }

  Future<void> _initializeCamera() async {
    final cameras = await availableCameras();

    // Find the front camera
    final frontCamera = cameras.firstWhere(
      (camera) => camera.lensDirection == CameraLensDirection.front,
      orElse: () => cameras.first,
    );

    _controller = CameraController(frontCamera, ResolutionPreset.high);

    await _controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {
        _cameraInitialized = true;
      });
      _controller.startImageStream(_processCameraImage);
    }).catchError((error) {
      // Handle initialization error
      print('Error initializing camera: $error');
    });
  }

  void _processCameraImage(CameraImage image) async {
    if (_isDetecting) return;
    _isDetecting = true;

    final inputImage = _getInputImage(image);

    final poses = await _poseDetector.processImage(inputImage);

    if (poses.isNotEmpty) {
      final pose = poses.first;

      final leftShoulder = pose.landmarks[PoseLandmarkType.leftShoulder];
      final rightShoulder = pose.landmarks[PoseLandmarkType.rightShoulder];
      final leftHip = pose.landmarks[PoseLandmarkType.leftHip];
      final rightHip = pose.landmarks[PoseLandmarkType.rightHip];
      final leftAnkle = pose.landmarks[PoseLandmarkType.leftAnkle];
      final rightAnkle = pose.landmarks[PoseLandmarkType.rightAnkle];

      if (leftShoulder != null &&
          rightShoulder != null &&
          leftHip != null &&
          rightHip != null &&
          leftAnkle != null &&
          rightAnkle != null) {
        final isArmsUp = _areArmsUp(leftShoulder, rightShoulder);
        final isLegsApart = _areLegsApart(leftAnkle, rightAnkle);

        if (isArmsUp && isLegsApart && !_isArmsUp) {
          setState(() {
            _jumpingJackCount++;
            _isArmsUp = true;
          });
        } else if (!isArmsUp) {
          _isArmsUp = false;
        }
      }
    }

    _isDetecting = false;
  }

  bool _areArmsUp(PoseLandmark leftShoulder, PoseLandmark rightShoulder) {
    return leftShoulder.y < rightShoulder.y + 30 &&
        rightShoulder.y < leftShoulder.y + 30;
  }

  bool _areLegsApart(PoseLandmark leftAnkle, PoseLandmark rightAnkle) {
    return (leftAnkle.x - rightAnkle.x).abs() > 150;
  }

  InputImage _getInputImage(CameraImage image) {
    final WriteBuffer allBytes = WriteBuffer();
    for (Plane plane in image.planes) {
      allBytes.putUint8List(plane.bytes);
    }
    final bytes = allBytes.done().buffer.asUint8List();

    final Size imageSize =
        Size(image.width.toDouble(), image.height.toDouble());

    final camera = _controller.description;

    final imageRotation =
        InputImageRotationValue.fromRawValue(camera.sensorOrientation) ??
            InputImageRotation.rotation0deg;

    final inputImageFormat =
        InputImageFormatValue.fromRawValue(image.format.raw) ??
            InputImageFormat.nv21;

    final metadata = InputImageMetadata(
      size: imageSize,
      rotation: imageRotation,
      format: inputImageFormat,
      bytesPerRow: image.planes[0].bytesPerRow,
    );

    return InputImage.fromBytes(
      bytes: bytes,
      metadata: metadata,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _poseDetector.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Jumping Jacks Counter'),
      ),
      body: _cameraInitialized
          ? Stack(
              children: [
                CameraPreview(_controller),
                Center(
                  child: Text(
                    'Reps: $_jumpingJackCount',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 50,
                  left: MediaQuery.of(context).size.width / 2 - 40,
                  child: Center(
                    child: GestureDetector(
                      onTap: () {
                        _controller.stopImageStream();
                        Navigator.of(context).pushNamed(
                          HomeSaveReps.routeName,
                          arguments: {
                            'reps': _jumpingJackCount,
                            'dailyGoal': widget.dailyWorkout!.dailyGoal,
                            'presRep': widget.dailyWorkout!.completedReps,
                          },
                        );
                      },
                      child: Image.asset(
                        'assets/images/stop.png',
                        width: 80,
                        height: 80,
                      ),
                    ),
                  ),
                ),
              ],
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
