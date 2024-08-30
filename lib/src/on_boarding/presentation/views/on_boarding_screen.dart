import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gainz_ai_app/core/common/widgets/gradient_background.dart';
import 'package:gainz_ai_app/core/extensions/context_extension.dart';
import 'package:gainz_ai_app/core/res/colours.dart';
import 'package:gainz_ai_app/core/res/fonts.dart';
import 'package:gainz_ai_app/core/res/media_res.dart';
import 'package:gainz_ai_app/src/auth/presentation/views/sign_in_screen.dart';
import 'package:gainz_ai_app/src/auth/presentation/views/sign_up_screen.dart';
import 'package:gainz_ai_app/src/on_boarding/domain/entities/page_content.dart';
import 'package:gainz_ai_app/src/on_boarding/presentation/cubit/on_boarding_cubit.dart';
import 'package:gainz_ai_app/src/on_boarding/presentation/widgets/on_boarding_body.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  static const routeName = '/onBoardingScreen';

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final PageController pageController = PageController();
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    // context.read<OnBoardingCubit>().checkIfUserIsFirstTimer();

    // Start the auto-scrolling timer
    _startAutoScroll();
  }

  void _startAutoScroll() {
    _timer = Timer.periodic(const Duration(seconds: 2), (timer) {
      int nextPage = (pageController.page?.toInt() ?? 0) + 1;
      if (nextPage >= 3) {
        nextPage = 0; // Loop back to the first page
      }
      pageController.animateToPage(
        nextPage,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel(); // Cancel the timer when the widget is disposed
    pageController.dispose(); // Dispose of the PageController
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<OnBoardingCubit, OnBoardingState>(
        listener: (context, state) {
          if (state is OnBoardingStatus && !state.isFirstTimer) {
            Navigator.pushReplacementNamed(context, '/home');
          } else if (state is UserCached) {
            Navigator.pushReplacementNamed(context, '/');
          } else if (state is OnBoardingError) {
            // Handle error case if needed
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          if (state is CheckingIfUserIsFirstTimer ||
              state is CachingFirstTimer) {
            return const Center(child: CircularProgressIndicator());
          }

          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: PageView(
                  controller: pageController,
                  children: const [
                    OnBoardingBody(pageContent: PageContent.first()),
                    OnBoardingBody(pageContent: PageContent.second()),
                    OnBoardingBody(pageContent: PageContent.third()),
                  ],
                ),
              ),
              SmoothPageIndicator(
                controller: pageController,
                count: 3,
                onDotClicked: (index) {
                  pageController.animateToPage(
                    index,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                  );
                },
                effect: const WormEffect(
                  dotHeight: 10,
                  dotWidth: 10,
                  spacing: 16,
                  activeDotColor: Colours.primaryColour,
                  dotColor: Colors.grey,
                ),
              ),
              const SizedBox(
                  height: 25), // Space between the indicator and buttons
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [
                    SizedBox(
                      width: context.width,
                      height: context.height * .058,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 50,
                            vertical: 17,
                          ),
                          backgroundColor: Colours.primaryColour,
                          foregroundColor: Colors.white,
                        ),
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, SignUpScreen.routeName);
                        },
                        child: const Text(
                          'Create an account',
                          style: TextStyle(
                            fontFamily: Fonts.aeonik,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16), // Space between buttons
                    SizedBox(
                      width: context.width,
                      height: context.height * .058,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          elevation: 0.2,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 50,
                            vertical: 17,
                          ),
                          backgroundColor: Color(0xffEBEBEB),
                          foregroundColor: Colors.black,
                        ),
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, SignInScreen.routeName);
                        },
                        child: const Text(
                          'Get Started',
                          style: TextStyle(
                            fontFamily: Fonts.aeonik,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40), // Space at the bottom
            ],
          );
        },
      ),
    );
  }
}
