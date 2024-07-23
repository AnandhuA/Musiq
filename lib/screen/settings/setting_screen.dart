import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:musiq/core/sized.dart';
import 'package:musiq/screen/settings/theme_screen.dart';
import 'package:musiq/screen/settings/widgets/list_tile_widget.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
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
                  builder: (context) => ThemeScreen(),
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
            onTap: () {},
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
