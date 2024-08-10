import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gainz_ai_app/core/errors/exceptions.dart';
import 'package:gainz_ai_app/core/utils/typedefs.dart';
import 'package:gainz_ai_app/src/home/data/model/dailyworkout_model.dart';
import 'package:intl/intl.dart';

abstract class DailyWorkoutRemoteDataSrc {
  const DailyWorkoutRemoteDataSrc();

  Future<void> setDailyGoal(String userId, DateTime date, int dailyGoal);
  Future<void> updateReps(String userId, DateTime date, int newReps);
  Future<DailyWorkoutModel?> getDailyWorkout(String userId, DateTime date);
}

class DailyWorkoutRemoteDataSrcImpl implements DailyWorkoutRemoteDataSrc {
  const DailyWorkoutRemoteDataSrcImpl({
    required FirebaseFirestore firestore,
    required FirebaseAuth auth,
  })  : _firestore = firestore,
        _auth = auth;

  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  @override
  Future<void> setDailyGoal(String userId, DateTime date, int dailyGoal) async {
    try {
      final user = _auth.currentUser;
      if (user == null) {
        throw const ServerException(
          message: 'User is not authenticated',
          statusCode: '401',
        );
      }

      // Format the date to "yyyy-MM-dd" to match your document IDs
      final dateFormatted = DateFormat('yyyy-MM-dd').format(date);

      final docRef = _firestore
          .collection('dailyWorkouts')
          .doc('${userId}_$dateFormatted');
      final workoutModel = DailyWorkoutModel(
        userId: userId,
        date: date,
        dailyGoal: dailyGoal,
        repsCompleted: 0,
      );

      await docRef.set(workoutModel.toMap(), SetOptions(merge: true));
    } on FirebaseException catch (e) {
      throw ServerException(
        message: e.message ?? 'Unknown error occurred',
        statusCode: e.code,
      );
    } on ServerException {
      rethrow;
    } catch (e) {
      throw ServerException(message: e.toString(), statusCode: '505');
    }
  }

  @override
  Future<void> updateReps(String userId, DateTime date, int newReps) async {
    try {
      final user = _auth.currentUser;
      if (user == null) {
        throw const ServerException(
          message: 'User is not authenticated',
          statusCode: '401',
        );
      }

      // Format the date to "yyyy-MM-dd" to match your document IDs
      final dateFormatted = DateFormat('yyyy-MM-dd').format(date);

      final docRef = _firestore
          .collection('dailyWorkouts')
          .doc('${userId}_$dateFormatted');
      final docSnapshot = await docRef.get();

      if (docSnapshot.exists) {
        final workout =
            DailyWorkoutModel.fromMap(docSnapshot.data() as DataMap);
        final updatedWorkout = workout.updateReps(newReps);
        await docRef.set(updatedWorkout.toMap(), SetOptions(merge: true));
      } else {
        // If no existing document, set it with initial reps
        await setDailyGoal(userId, date, 0); // Default goal of 0
        final workout = DailyWorkoutModel(
          userId: userId,
          date: date,
          dailyGoal: 0, // Default value; adjust as needed
          repsCompleted: newReps,
        );
        await docRef.set(workout.toMap(), SetOptions(merge: true));
      }
    } on FirebaseException catch (e) {
      throw ServerException(
        message: e.message ?? 'Unknown error occurred',
        statusCode: e.code,
      );
    } on ServerException {
      rethrow;
    } catch (e) {
      throw ServerException(message: e.toString(), statusCode: '505');
    }
  }

  @override
  Future<DailyWorkoutModel?> getDailyWorkout(
      String userId, DateTime date) async {
    try {
      final user = _auth.currentUser;
      if (user == null) {
        throw const ServerException(
          message: 'User is not authenticated',
          statusCode: '401',
        );
      }

      // Format the date to "yyyy-MM-dd" to match your document IDs
      final dateFormatted = DateFormat('yyyy-MM-dd').format(date);
      print(dateFormatted);
      final docRef = _firestore
          .collection('dailyWorkouts')
          .doc('${userId}_$dateFormatted');
      final docSnapshot = await docRef.get();

      // print(docSnapshot.data()!.length);
      if (docSnapshot.exists) {
        DailyWorkoutModel data =
            DailyWorkoutModel.fromMap(docSnapshot.data() as DataMap);
        print(data.dailyGoal);
        return data;
      } else {
        final defaultMap = {
          'userId': userId,
          'date': dateFormatted, // Store the date in "yyyy-MM-dd" format
          'dailyGoal': 0,
          'repsCompleted': 0,
        };
        return DailyWorkoutModel.fromMap(defaultMap);
      }
    } on FirebaseException catch (e) {
      throw ServerException(
        message: e.message ?? 'Unknown error occurred',
        statusCode: e.code,
      );
    } on ServerException {
      rethrow;
    } catch (e) {
      throw ServerException(message: e.toString(), statusCode: '505');
    }
  }
}
