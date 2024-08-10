import 'package:gainz_ai_app/core/utils/typedefs.dart';
import 'package:gainz_ai_app/src/home/data/model/dailyworkout_model.dart';

abstract class DailyWorkoutRepo {
  const DailyWorkoutRepo();

  ResultFuture<void> setDailyGoal(String userId, DateTime date, int dailyGoal);
  ResultFuture<void> updateReps(String userId, DateTime date, int newReps);
  ResultFuture<DailyWorkoutModel?> getDailyWorkout(String userId, DateTime date);
}
