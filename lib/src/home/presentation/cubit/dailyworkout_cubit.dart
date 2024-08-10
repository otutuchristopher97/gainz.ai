import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gainz_ai_app/src/home/domain/entities/dailyworkout.dart';
import 'package:gainz_ai_app/src/home/domain/usecases/get_dailyworkout_goall.dart';
import 'package:gainz_ai_app/src/home/domain/usecases/set_daily_goal.dart';
import 'package:gainz_ai_app/src/home/domain/usecases/update_daily_reps_goal.dart';

part 'dailyworkout_state.dart';

class DailyWorkoutCubit extends Cubit<DailyWorkoutState> {
  DailyWorkoutCubit({
    required SetDailyGoal setDailyGoal,
    required UpdateReps updateReps,
    required GetDailyWorkout getDailyWorkout,
  })  : _setDailyGoal = setDailyGoal,
        _updateReps = updateReps,
        _getDailyWorkout = getDailyWorkout,
        super(DailyWorkoutInitial());

  final SetDailyGoal _setDailyGoal;
  final UpdateReps _updateReps;
  final GetDailyWorkout _getDailyWorkout;

  Future<void> setDailyGoal(DailyWorkout dailyWorkout) async {
    print('cubit: ${dailyWorkout.dailyGoal}');
    emit(DailyWorkoutLoading());
    final result = await _setDailyGoal(dailyWorkout);
    result.fold(
      (failure) => emit(DailyWorkoutError(failure.errorMessage)),
      (_) => emit(DailyWorkoutGoalSet()),
    );
  }

  Future<void> updateReps(DailyWorkout dailyWorkout) async {
    emit(DailyWorkoutLoading());
    final result = await _updateReps(dailyWorkout);
    result.fold(
      (failure) => emit(DailyWorkoutError(failure.errorMessage)),
      (_) => emit(DailyWorkoutUpdated()),
    );
  }

  Future<void> getDailyWorkout(String userId, DateTime date) async {
    emit(DailyWorkoutLoading());
    final result = await _getDailyWorkout(GetDailyWorkoutParams(userId: userId, date: date));
    result.fold(
      (failure) => emit(DailyWorkoutError(failure.errorMessage)),
      (dailyWorkout) {
        if (dailyWorkout != null) {
          emit(DailyWorkoutLoaded(dailyWorkout));
        } else {
          emit(const DailyWorkoutError('No workout found for the specified date.'));
        }
      },
    );
  }

}
