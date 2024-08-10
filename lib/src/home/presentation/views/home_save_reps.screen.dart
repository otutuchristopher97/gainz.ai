import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gainz_ai_app/core/common/app/providers/user_provider.dart';
import 'package:gainz_ai_app/core/common/widgets/customer_text.dart';
import 'package:gainz_ai_app/core/common/widgets/rounded_button.dart';
import 'package:gainz_ai_app/core/utils/core_utils.dart';
import 'package:gainz_ai_app/src/dashboard/presentation/views/dashboard.dart';
import 'package:gainz_ai_app/src/home/domain/entities/dailyworkout.dart';
import 'package:gainz_ai_app/src/home/presentation/cubit/dailyworkout_cubit.dart';
import 'package:provider/provider.dart';

class HomeSaveReps extends StatefulWidget {
  HomeSaveReps({required this.map, super.key});

  final Map<String, dynamic>? map;

  static const routeName = '/home-save-reps-screen';

  @override
  State<HomeSaveReps> createState() => _HomeSaveRepsState();
}

class _HomeSaveRepsState extends State<HomeSaveReps> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(
              height: 150,
            ),
            Image.asset(
              'assets/images/flag.png',
              height: 150,
              width: 300,
            ),
            const SizedBox(
              height: 50,
            ),
            CustomText(
              text: 'You’re a master!',
              fontWeight: FontWeight.w600,
              fontSize: 16,
              color: const Color(0xff090F47),
            ),
            const SizedBox(
              height: 20,
            ),
            CustomText(
              text: '${widget.map!['reps']} reps',
              fontWeight: FontWeight.w600,
              fontSize: 32,
              color: const Color(0xff090F47),
            ),
            Expanded(child: SizedBox()),
            RoundedButton(
              onPressed: () async {
                final userId =
                    Provider.of<UserProvider>(context, listen: false).user?.uid;

                if (userId != null) {
                  if (widget.map!['reps'] + widget.map!['presRep'] >
                      widget.map!['dailyGoal']) {
                    CoreUtils.showSnackBar(context,
                        "You have exceeded your daily goal, try again");
                    return;
                  } else {
                    await context.read<DailyWorkoutCubit>().updateReps(
                        DailyWorkout(
                            completedReps: widget.map!['reps'],
                            dailyGoal: widget.map!['dailyGoal'],
                            date: DateTime.now(),
                            userId: userId));
                    Navigator.pushReplacementNamed(
                        context, Dashboard.routeName);
                  }
                }
              },
              label: 'Save',
            ),
            const SizedBox(
              height: 20,
            ),
            RoundedButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
              label: 'Try Again',
              buttonColour: const Color(0xffD9D9D9),
            ),
            const SizedBox(
              height: 40,
            ),
          ],
        ),
      ),
    );
  }
}
