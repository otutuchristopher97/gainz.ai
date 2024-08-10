import 'package:dartz/dartz.dart';
import 'package:gainz_ai_app/core/usecases/usecases.dart';
import 'package:gainz_ai_app/core/utils/typedefs.dart';
import 'package:gainz_ai_app/src/home/domain/entities/dailyworkout.dart';
import 'package:gainz_ai_app/src/home/domain/repo/dailyworkout_repo.dart';

class GetDailyWorkout extends FutureUsecaseWithParams<DailyWorkout?, GetDailyWorkoutParams> {
  const GetDailyWorkout(this._repo);

  final DailyWorkoutRepo _repo;

  @override
  ResultFuture<DailyWorkout?> call(GetDailyWorkoutParams params) async {
    final result = await _repo.getDailyWorkout(params.userId, params.date);
    return result.fold(
      (failure) => Left(failure),
      (dailyWorkoutModel) {
        if (dailyWorkoutModel != null) {
          return Right(DailyWorkout(
            userId: dailyWorkoutModel.userId,
            date: dailyWorkoutModel.date,
            dailyGoal: dailyWorkoutModel.dailyGoal,
            completedReps: dailyWorkoutModel.repsCompleted,
          ));
        } else {
          return const Right(null);
        }
      },
    );
  }
}

class GetDailyWorkoutParams {
  final String userId;
  final DateTime date;

  GetDailyWorkoutParams({
    required this.userId,
    required this.date,
  });
}