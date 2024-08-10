import 'package:equatable/equatable.dart';

class DailyWorkout extends Equatable {
  const DailyWorkout({
    required this.userId,
    required this.date,
    required this.dailyGoal,
    required this.completedReps,
  });

  DailyWorkout.empty()
      : this(
          userId: '_empty.userId',
          date: DateTime.now(),
          dailyGoal: 0,
          completedReps: 0,
        );

  final String userId;
  final DateTime date;
  final int dailyGoal;
  final int completedReps;

  @override
  List<Object?> get props => [userId, date];
}
