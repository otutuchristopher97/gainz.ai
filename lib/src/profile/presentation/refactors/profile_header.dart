import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gainz_ai_app/core/common/app/providers/user_provider.dart';
import 'package:gainz_ai_app/core/extensions/context_extension.dart';
import 'package:gainz_ai_app/core/res/colours.dart';
import 'package:gainz_ai_app/core/res/media_res.dart';
import 'package:flutter/material.dart';
import 'package:gainz_ai_app/core/services/injection_container.dart';
import 'package:gainz_ai_app/src/auth/presentation/bloc/auth_bloc.dart';
import 'package:gainz_ai_app/src/profile/presentation/views/edit_profile_view.dart';
import 'package:provider/provider.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (_, provider, __) {
        final user = provider.user;
        final image = user?.profilePic == null || user!.profilePic!.isEmpty
            ? null
            : user.profilePic;
        return Column(
          children: [
            ListTile(
              contentPadding: EdgeInsets.zero,
              horizontalTitleGap: 0,
              minLeadingWidth: 5,
              leading: CircleAvatar(
                radius: 50,
                backgroundImage: image != null
                    ? NetworkImage(image)
                    : const AssetImage(MediaRes.user) as ImageProvider,
              ),
              title: Text(
                user?.fullName ?? 'No User',
                style:
                    const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
              ),
              subtitle: Text(
                user?.email ?? 'No Email',
                style: const TextStyle(
                  fontSize: 12,
                  color: Colours.neutralTextColour,
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Divider(
              color: Color.fromARGB(255, 239, 236, 236),
            ),
            const SizedBox(height: 10),
            ListTile(
              contentPadding: EdgeInsets.zero,
              horizontalTitleGap: 10,
              minLeadingWidth: 15,
              leading: Image.asset(
                'assets/icons/user.png',
                height: 24,
                width: 24,
              ),
              title: const Text(
                'Edit Profile',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
              ),
              onTap: () => context.push(
                BlocProvider(
                  create: (_) => sl<AuthBloc>(),
                  child: const EditProfileView(),
                ),
              ),
            ),
            const SizedBox(height: 10),
            const Divider(
              color: Color.fromARGB(255, 239, 236, 236),
            ),
            const SizedBox(height: 10),
            ListTile(
              contentPadding: EdgeInsets.zero,
              horizontalTitleGap: 10,
              minLeadingWidth: 15,
              leading: Image.asset(
                'assets/icons/layers.png',
                height: 24,
                width: 24,
              ),
              title: const Text(
                'History',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
              ),
            ),
            const SizedBox(height: 10),
            const Divider(
              color: Color.fromARGB(255, 239, 236, 236),
            ),
            const SizedBox(height: 10),
            ListTile(
              contentPadding: EdgeInsets.zero,
              horizontalTitleGap: 10,
              minLeadingWidth: 15,
              leading: Image.asset(
                'assets/icons/help-circle.png',
                height: 24,
                width: 24,
              ),
              title: const Text(
                'About Us',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
              ),
            ),
            const SizedBox(height: 10),
            const Divider(
              color: Color.fromARGB(255, 239, 236, 236),
            ),
            const SizedBox(height: 10),
            ListTile(
              contentPadding: EdgeInsets.zero,
              horizontalTitleGap: 10,
              minLeadingWidth: 15,
              leading: Image.asset(
                'assets/icons/log-out.png',
                height: 24,
                width: 24,
              ),
              title: const Text(
                'Log Out',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
              ),
              onTap: () async {
                final navigator = Navigator.of(context);
                await FirebaseAuth.instance.signOut();
                unawaited(
                  navigator.pushNamedAndRemoveUntil(
                    '/',
                    (route) => false,
                  ),
                );
              },
            ),
            const SizedBox(height: 10),
            const Divider(
              color: Color.fromARGB(255, 239, 236, 236),
            ),
            const SizedBox(height: 10),
          ],
        );
      },
    );
  }
}
