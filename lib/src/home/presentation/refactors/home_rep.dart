import 'package:flutter/material.dart';
import 'package:gainz_ai_app/src/home/domain/entities/dailyworkout.dart';
import 'package:gainz_ai_app/src/home/presentation/refactors/home_container.dart';
import 'package:gainz_ai_app/src/home/presentation/refactors/home_indicator.dart';

class HomeRepScreen extends StatefulWidget {
  const HomeRepScreen({super.key, required this.dailyWorkout});

  final DailyWorkout? dailyWorkout;

  @override
  State<HomeRepScreen> createState() => _HomeRepScreenState();
}

class _HomeRepScreenState extends State<HomeRepScreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              HomeIndicator(
                dailyWorkout: widget.dailyWorkout,
              ),
              // const SizedBox(height: 10),
              SizedBox(
                height: 160,
                child: GridView(
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 15.0,
                  ),
                  children: [
                    HomeContainer(
                      title: 'Exercise',
                      subtitle: '${widget.dailyWorkout?.completedReps} reps',
                      image: 'assets/icons/exercise.png',
                      color: const Color(0xffD9D9D9).withOpacity(0.3),
                    ),
                    HomeContainer(
                      title: 'Goal',
                      subtitle:
                          '${(widget.dailyWorkout!.dailyGoal)}',
                      image: 'assets/icons/goal.png',
                      color: const Color(0xff8274ED).withOpacity(0.1),
                      percentage: widget.dailyWorkout!.completedReps / widget.dailyWorkout!.dailyGoal
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
