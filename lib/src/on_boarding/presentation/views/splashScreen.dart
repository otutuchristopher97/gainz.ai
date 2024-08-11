import 'dart:async';
import 'package:flutter/material.dart';
import 'package:gainz_ai_app/core/common/widgets/customer_text.dart';

class SplashScreen extends StatefulWidget {
  static const routeName = '/splash';

  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  late Timer timer;

  @override
  void initState() {
    super.initState();
    timer = Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, '/');
    });
  }

  @override
  void dispose() {
    if (timer.isActive) {
      timer.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: CustomText(
          text: 'Gainz.AI',
          fontSize: 35,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
