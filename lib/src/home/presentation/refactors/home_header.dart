import 'package:gainz_ai_app/core/common/app/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: Stack(
        children: [
          GestureDetector(
            onTap: () {
              print(context.watch<UserProvider>().user!.fullName);
            },
            child: Text(
              'Hello\n${context.watch<UserProvider>().user!.fullName}',
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 36,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
