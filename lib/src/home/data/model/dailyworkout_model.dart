import 'dart:convert';
import 'package:gainz_ai_app/core/utils/typedefs.dart';

class DailyWorkoutModel {
  final String userId;
  final DateTime date;
  final int dailyGoal;
  final int repsCompleted;

  const DailyWorkoutModel({
    required this.userId,
    required this.date,
    required this.dailyGoal,
    required this.repsCompleted,
  });

  factory DailyWorkoutModel.fromJson(String source) =>
      DailyWorkoutModel.fromMap(jsonDecode(source) as DataMap);

  DailyWorkoutModel.empty()
      : this(
          userId: '',
          date: DateTime.now(), 
          dailyGoal: 0,
          repsCompleted: 0,
        );

  DailyWorkoutModel.fromMap(DataMap map)
      : this(
          userId: map['userId'] as String,
          date: DateTime.parse(map['date'] as String),
          dailyGoal: (map['dailyGoal'] as num).toInt(),
          repsCompleted: (map['repsCompleted'] as num).toInt(),
        );

  DailyWorkoutModel copyWith({
    String? userId,
    DateTime? date,
    int? dailyGoal,
    int? repsCompleted,
  }) {
    return DailyWorkoutModel(
      userId: userId ?? this.userId,
      date: date ?? this.date,
      dailyGoal: dailyGoal ?? this.dailyGoal,
      repsCompleted: repsCompleted ?? this.repsCompleted,
    );
  }

  DataMap toMap() {
    return <String, dynamic>{
      'userId': userId,
      'date': date.toIso8601String(),
      'dailyGoal': dailyGoal,
      'repsCompleted': repsCompleted,
    };
  }

  // This method updates the repsCompleted field
  DailyWorkoutModel updateReps(int newReps) {
    return copyWith(
      repsCompleted: repsCompleted + newReps,
    );
  }
}
