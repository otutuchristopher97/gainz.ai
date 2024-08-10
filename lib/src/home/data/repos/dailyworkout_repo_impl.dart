import 'package:dartz/dartz.dart';
import 'package:gainz_ai_app/core/errors/exceptions.dart';
import 'package:gainz_ai_app/core/errors/failures.dart';
import 'package:gainz_ai_app/core/utils/typedefs.dart';
import 'package:gainz_ai_app/src/home/data/datasorces/dailyworkout_remote_data_src.dart';
import 'package:gainz_ai_app/src/home/data/model/dailyworkout_model.dart';
import 'package:gainz_ai_app/src/home/domain/repo/dailyworkout_repo.dart';

class DailyWorkoutRepoImpl implements DailyWorkoutRepo {
  const DailyWorkoutRepoImpl(this._remoteDataSrc);

  final DailyWorkoutRemoteDataSrc _remoteDataSrc;

  @override
  ResultFuture<void> setDailyGoal(String userId, DateTime date, int dailyGoal) async {
    try {
      await _remoteDataSrc.setDailyGoal(userId, date, dailyGoal);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    } catch (e) {
      return Left(ServerFailure(message: e.toString(), statusCode: '505'));
    }
  }

  @override
  ResultFuture<void> updateReps(String userId, DateTime date, int newReps) async {
    try {
      await _remoteDataSrc.updateReps(userId, date, newReps);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    } catch (e) {
      return Left(ServerFailure(message: e.toString(), statusCode: '505'));
    }
  }

  @override
  ResultFuture<DailyWorkoutModel?> getDailyWorkout(String userId, DateTime date) async {
    try {
      final workout = await _remoteDataSrc.getDailyWorkout(userId, date);
      return Right(workout);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    } catch (e) {
      return Left(ServerFailure(message: e.toString(), statusCode: '505'));
    }
  }
}
