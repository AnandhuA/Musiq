import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:musiq/core/sized.dart';
import 'package:musiq/presentation/commanWidgets/confirmation_diloge.dart';
import 'package:musiq/presentation/screens/settingsScreen/theme_screen.dart';
import 'package:musiq/presentation/screens/settingsScreen/widgets/list_tile_widget.dart';
import 'package:musiq/presentation/screens/splashScreen/splash_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
        actions: [
          Lottie.asset("assets/animations/Animation1.json"),
        ],
      ),
      body: Column(
        children: [
          constHeight30,
          MultiListTileWidget(
            icon1: const Icon(Icons.info_outline),
            title1: "About",
            onTap1: () {
              log("about");
            },
            icon2: const Icon(Icons.privacy_tip_outlined),
            title2: "Privacy and policy",
            onTap2: () {
              log("privcy");
            },
          ),
          constHeight20,
          ListTileWidget(
            icon: const Icon(Icons.dark_mode_outlined),
            title: "Theme",
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ThemeScreen(),
                ),
              );
            },
          ),
          constHeight20,
          ListTileWidget(
            icon: const Icon(
              Icons.login_outlined,
              color: Colors.red,
            ),
            logout: true,
            title: "Log out",
            onTap: () {
              confirmationDiloge(
                context: context,
                title: "Logout Confirmation",
                confirmBtn: () async {
                  await FirebaseAuth.instance.signOut();
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SplashScreen(),
                    ),
                    (route) => false,
                  );
                },
                content: "Are you sure you want to logout?",
              );
            },
          ),
          const Spacer(),
          Text(
            "v1.0",
            style: theme.textTheme.titleMedium,
          ),
          constHeight50,
        ],
      ),
    );
  }
}
