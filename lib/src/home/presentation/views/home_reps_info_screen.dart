import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gainz_ai_app/core/common/app/providers/user_provider.dart';
import 'package:gainz_ai_app/core/common/widgets/customer_text.dart';
import 'package:gainz_ai_app/core/common/widgets/rounded_button.dart';
import 'package:gainz_ai_app/core/res/colours.dart';
import 'package:gainz_ai_app/src/dashboard/presentation/views/dashboard.dart';
import 'package:gainz_ai_app/src/home/domain/entities/dailyworkout.dart';
import 'package:gainz_ai_app/src/home/presentation/cubit/dailyworkout_cubit.dart';
import 'package:msh_checkbox/msh_checkbox.dart';
import 'package:provider/provider.dart';

class HomeRepsInfoScreen extends StatefulWidget {
  const HomeRepsInfoScreen({super.key});

  static const routeName = '/home-reps-info-screen';

  @override
  State<HomeRepsInfoScreen> createState() => _HomeRepsInfoScreenState();
}

class _HomeRepsInfoScreenState extends State<HomeRepsInfoScreen> {
  void showTargetSettingDialog(BuildContext context) {
    TextEditingController _controller = TextEditingController();
    final _formKey = GlobalKey<FormState>();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.zero,
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          title: const Text(
            'Set your target',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          content: Builder(
            builder: (BuildContext context) {
              return SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context)
                        .viewInsets
                        .bottom, // Add padding for the keyboard
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20.0,
                          ),
                          child: Text(
                            'Define the number of reps you aim to achieve.',
                            style: TextStyle(
                                fontSize: 14, color: Colors.grey[600]),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 10),
                          child: TextFormField(
                            controller: _controller,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              hintText: 'Enter target reps',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                  color: Colours.primaryColour,
                                ),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter a valid number.';
                              }
                              final int? target = int.tryParse(value);
                              if (target == null || target <= 0) {
                                return 'Please enter a positive number.';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
          actions: [
            RoundedButtonView(
              label: 'Save',
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  final dailyGoal = int.parse(_controller.text);

                  final userId =
                      Provider.of<UserProvider>(context, listen: false)
                          .user
                          ?.uid;
                  final date = DateTime.now();

                  if (userId != null) {
                    context.read<DailyWorkoutCubit>().setDailyGoal(
                          DailyWorkout(
                            userId: userId,
                            date: date,
                            dailyGoal: dailyGoal,
                            completedReps: 0,
                          ),
                        );

                    Navigator.pop(context);
                    Navigator.pushReplacementNamed(
                        context, Dashboard.routeName);
                  }
                }
              },
            ),
            const SizedBox(height: 20),
            RoundedButtonView(
              label: 'Cancel',
              buttonColour: const Color(0xffD9D9D9),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.25,
              ),
              CustomText(
                text: 'Unlock Your Full Potential',
                fontSize: 22,
                fontWeight: FontWeight.w600,
              ),
              const SizedBox(
                height: 10,
              ),
              CustomText(
                text: 'Comprehensive Health and Wellness Plan',
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  MSHCheckbox(
                    size: 20,
                    value: true,
                    colorConfig: MSHColorConfig.fromCheckedUncheckedDisabled(
                      checkedColor: const Color(0xff32BA7C),
                    ),
                    style: MSHCheckboxStyle.fillScaleColor,
                    onChanged: (selected) {},
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    child: CustomText(
                      text:
                          'Stay on top of your health with direct access to professionals',
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      maxLines: 2,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  MSHCheckbox(
                    size: 20,
                    value: true,
                    colorConfig: MSHColorConfig.fromCheckedUncheckedDisabled(
                      checkedColor: const Color(0xff32BA7C),
                    ),
                    style: MSHCheckboxStyle.fillScaleColor,
                    onChanged: (selected) {},
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    child: CustomText(
                      text:
                          'Track your health metrics from the comfort of your home',
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      maxLines: 2,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  MSHCheckbox(
                    size: 20,
                    value: true,
                    colorConfig: MSHColorConfig.fromCheckedUncheckedDisabled(
                      checkedColor: const Color(0xff32BA7C),
                    ),
                    style: MSHCheckboxStyle.fillScaleColor,
                    onChanged: (selected) {},
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    child: CustomText(
                      text:
                          'Gain insights and tips on maintaining a healthy lifestyle',
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      maxLines: 2,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  MSHCheckbox(
                    size: 20,
                    value: true,
                    colorConfig: MSHColorConfig.fromCheckedUncheckedDisabled(
                      checkedColor: const Color(0xff32BA7C),
                    ),
                    style: MSHCheckboxStyle.fillScaleColor,
                    onChanged: (selected) {},
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    child: CustomText(
                      text:
                          'Personalized advice to keep your diet balanced and nutritious',
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      maxLines: 2,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  MSHCheckbox(
                    size: 20,
                    value: true,
                    colorConfig: MSHColorConfig.fromCheckedUncheckedDisabled(
                      checkedColor: const Color(0xff32BA7C),
                    ),
                    style: MSHCheckboxStyle.fillScaleColor,
                    onChanged: (selected) {},
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    child: CustomText(
                      text: 'Save on essential medications and supplements',
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      maxLines: 2,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  MSHCheckbox(
                    size: 20,
                    value: true,
                    colorConfig: MSHColorConfig.fromCheckedUncheckedDisabled(
                      checkedColor: const Color(0xff32BA7C),
                    ),
                    style: MSHCheckboxStyle.fillScaleColor,
                    onChanged: (selected) {},
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    child: CustomText(
                      text: 'Enjoy a range of benefits',
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      maxLines: 2,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  MSHCheckbox(
                    size: 20,
                    value: true,
                    colorConfig: MSHColorConfig.fromCheckedUncheckedDisabled(
                      checkedColor: const Color(0xff32BA7C),
                    ),
                    style: MSHCheckboxStyle.fillScaleColor,
                    onChanged: (selected) {},
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    child: CustomText(
                      text:
                          'Connect with others on the same journey through the Rigour+ Health Community',
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      maxLines: 2,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  MSHCheckbox(
                    size: 20,
                    value: true,
                    colorConfig: MSHColorConfig.fromCheckedUncheckedDisabled(
                      checkedColor: const Color(0xff32BA7C),
                    ),
                    style: MSHCheckboxStyle.fillScaleColor,
                    onChanged: (selected) {},
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    child: CustomText(
                      text:
                          'Prioritize your mental well-being with expert support',
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      maxLines: 2,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              const SizedBox(
                height: 70,
              ),
              Center(
                child: SizedBox(
                  width: 310,
                  height: 65,
                  child: RoundedButton(
                    label: 'Start Rep',
                    onPressed: () {
                      showTargetSettingDialog(context);
                    },
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RoundedButtonView extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final Color? buttonColour;
  final Color? labelColour;

  const RoundedButtonView({
    required this.label,
    required this.onPressed,
    this.buttonColour,
    this.labelColour,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity, // Make the button take full width
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: buttonColour ?? Theme.of(context).primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.symmetric(
              vertical: 15), // Adjust padding as needed
        ),
        onPressed: onPressed,
        child: Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
