import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:musiq/core/colors.dart';
import 'package:musiq/core/global_variables.dart';
import 'package:musiq/core/sized.dart';
import 'package:musiq/presentation/commanWidgets/confirmation_diloge.dart';
import 'package:musiq/presentation/screens/loginScreen/login_screen.dart';
import 'package:musiq/presentation/screens/settingsScreen/about_screen.dart';
import 'package:musiq/presentation/screens/settingsScreen/theme_screen.dart';
import 'package:musiq/presentation/screens/settingsScreen/widgets/list_tile_widget.dart';
import 'package:musiq/presentation/screens/settingsScreen/widgets/privacy_and_policy.dart';
import 'package:musiq/presentation/screens/splashScreen/splash_screen.dart';
import 'package:package_info_plus/package_info_plus.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String version = "";
  @override
  void initState() {
    getVersion();
    super.initState();
  }

  Future<void> getVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    version = packageInfo.version;
    log("-------------$version");
    String buildNumber = packageInfo.buildNumber;
    print('Version: $version, Build Number: $buildNumber');
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios_new_sharp)),
        actions: [
          Lottie.asset("assets/animations/Animation1.json"),
        ],
      ),
      body: Column(
        children: [
          AppSpacing.height30,
          MultiListTileWidget(
            icon1: const Icon(Icons.info_outline),
            title1: "About",
            onTap1: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AboutScreen(),
                  ));
            },
            icon2: const Icon(Icons.privacy_tip_outlined),
            title2: "Privacy and policy",
            onTap2: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PrivacyAndPolicy(),
                  ));
            },
          ),
          AppSpacing.height20,
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
          AppSpacing.height20,
          AppGlobals().userIsLoggedIn != null
              ? ListTileWidget(
                  icon: const Icon(
                    Icons.login_outlined,
                    color: AppColors.red,
                  ),
                  logout: true,
                  title: "Log out",
                  onTap: () {
                    confirmationDiloge(
                      context: context,
                      title: "Logout Confirmation",
                      confirmBtn: () async {
                        await FirebaseAuth.instance.signOut();
                        AppGlobals().userIsLoggedIn = null;
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
                )
              : ListTileWidget(
                  icon: const Icon(
                    Icons.login_outlined,
                    color: AppColors.green,
                  ),
                  title: "Log In",
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginScreen(),
                        ));
                  },
                ),
          const Spacer(),
          Text(
            "v$version",
            style: theme.textTheme.titleMedium,
          ),
          AppSpacing.height50,
        ],
      ),
    );
  }
}
