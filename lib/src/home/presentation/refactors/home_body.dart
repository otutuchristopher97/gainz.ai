import 'package:gainz_ai_app/core/common/app/providers/user_provider.dart';
import 'package:gainz_ai_app/src/home/presentation/cubit/dailyworkout_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gainz_ai_app/src/home/presentation/refactors/home_rep.dart';

class HomeBody extends StatefulWidget {
  const HomeBody({super.key});

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    getDailyWorkout();
  }

  void getDailyWorkout() {
    final userId = context.watch<UserProvider>().user?.uid;
    if (userId != null) {
      context.read<DailyWorkoutCubit>().getDailyWorkout(userId, DateTime.now());
    } else {
      print('User ID is null');
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DailyWorkoutCubit, DailyWorkoutState>(
      listener: (context, state) {
        if (state is DailyWorkoutError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.errorMessage)),
          );
        }
      },
      builder: (context, state) {
        if (state is DailyWorkoutLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is DailyWorkoutLoaded) {
          // Handle the loaded state and display relevant data
          final dailyWorkout = state.dailyWorkout;
          return HomeRepScreen(dailyWorkout: dailyWorkout);
        } else if (state is DailyWorkoutError) {
          return Center(child: Text('Error: ${state.errorMessage}'));
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
