part of 'dailyworkout_cubit.dart';

abstract class DailyWorkoutState extends Equatable {
  const DailyWorkoutState();

  @override
  List<Object?> get props => [];
}

class DailyWorkoutInitial extends DailyWorkoutState {}

class DailyWorkoutLoading extends DailyWorkoutState {}

class DailyWorkoutGoalSet extends DailyWorkoutState {}

class DailyWorkoutUpdated extends DailyWorkoutState {}

class DailyWorkoutLoaded extends DailyWorkoutState {
  const DailyWorkoutLoaded(this.dailyWorkout);

  final DailyWorkout dailyWorkout;

  @override
  List<Object?> get props => [dailyWorkout];
}

class DailyWorkoutError extends DailyWorkoutState {
  const DailyWorkoutError(this.errorMessage);

  final String errorMessage;

  @override
  List<Object?> get props => [errorMessage];
}
