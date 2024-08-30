import 'package:gainz_ai_app/core/common/widgets/gradient_background.dart';
import 'package:gainz_ai_app/core/res/media_res.dart';
import 'package:gainz_ai_app/src/home/presentation/refactors/home_body.dart';
import 'package:gainz_ai_app/src/home/presentation/widgets/home_app_bar.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      appBar: const HomeAppBar(),
      body: GradientBackground(
        image: MediaRes.homeGradientBackground,
        child: GestureDetector(
          onTap: (){
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: const HomeBody()),
      ),
    );
  }
}
