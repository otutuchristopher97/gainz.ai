import 'package:flutter/material.dart';
import 'package:gainz_ai_app/core/common/widgets/rounded_button.dart';
import 'package:gainz_ai_app/src/home/domain/entities/dailyworkout.dart';
import 'package:gainz_ai_app/src/home/presentation/views/home_pose_rep.dart';
import 'package:gainz_ai_app/src/home/presentation/views/home_reps_info_screen.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class HomeIndicator extends StatefulWidget {
  HomeIndicator({super.key, required this.dailyWorkout});

  DailyWorkout? dailyWorkout;

  @override
  State<HomeIndicator> createState() => _HomeIndicatorState();
}

class _HomeIndicatorState extends State<HomeIndicator> {
  final centerTextStyle = const TextStyle(
    fontSize: 64,
    color: Colors.lightBlue,
    fontWeight: FontWeight.bold,
  );

  late ValueNotifier<double> valueNotifier;

  @override
  void initState() {
    super.initState();
    valueNotifier = ValueNotifier(0.0);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            CircularPercentIndicator(
              radius: 120.0,
              lineWidth: 20.0,
              animation: true,
              percent: widget.dailyWorkout!.completedReps /
                  widget.dailyWorkout!.dailyGoal,
              center: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.dailyWorkout!.completedReps.toString(),
                    style: const TextStyle(
                        fontWeight: FontWeight.w600, fontSize: 32.0),
                  ),
                  const Text(
                    "Reps",
                    style:
                        TextStyle(fontWeight: FontWeight.w600, fontSize: 16.0),
                  ),
                ],
              ),
              circularStrokeCap: CircularStrokeCap.round,
              linearGradient: const LinearGradient(
                colors: [
                  Color(0xff02F0FF),
                  Color(0xff685EB2),
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              width: 310,
              height: 65,
              child: RoundedButton(
                label: 'Start Rep',
                onPressed: () {
                  if (widget.dailyWorkout!.dailyGoal == 0) {
                    Navigator.pushNamed(context, HomeRepsInfoScreen.routeName);
                  } else {
                    Navigator.pushNamed(context, HomePoseRepScreen.routeName,
                        arguments: widget.dailyWorkout);
                  }
                },
              ),
            ),
            const SizedBox(
              height: 30,
            ),
          ],
        ));
  }
}
