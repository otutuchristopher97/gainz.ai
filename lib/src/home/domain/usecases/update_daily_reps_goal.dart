import 'package:gainz_ai_app/core/usecases/usecases.dart';
import 'package:gainz_ai_app/core/utils/typedefs.dart';
import 'package:gainz_ai_app/src/home/domain/entities/dailyworkout.dart';
import 'package:gainz_ai_app/src/home/domain/repo/dailyworkout_repo.dart';

class UpdateReps extends FutureUsecaseWithParams<void, DailyWorkout> {
  const UpdateReps(this._repo);

  final DailyWorkoutRepo _repo;

  @override
  ResultFuture<void> call(DailyWorkout dailyWorkout) async {
    return _repo.updateReps(
      dailyWorkout.userId,
      dailyWorkout.date,
      dailyWorkout.completedReps,
    );
  }
}
