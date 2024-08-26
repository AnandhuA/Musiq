import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:musiq/data/shared_preference.dart';
import 'package:musiq/main.dart';

import 'package:musiq/presentation/mainPage.dart/main_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _startApp();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Lottie.asset(
          "assets/animations/Animation - 1721731246317.json",
        ),
      ),
    );
  }

  void _startApp() async {
    theme = await SharedPreference.getTheme();
    colorIndex = await SharedPreference.getColorIndex() ?? 0;
    lastplayed = await SharedPreference.getLastPlayedSong();
    userIsLoggedIn = FirebaseAuth.instance.currentUser?.email;
    log("splash");
    if (!mounted) return;
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => const MainPage(),
      ),
      (route) => false,
    );

    // if (firebaseAuth.currentUser == null) {
    //   Navigator.of(context).pushReplacement(MaterialPageRoute(
    //     builder: (context) => LoginScreen(),
    //   ));
    // } else {
    //   Navigator.of(context).pushReplacement(
    //     MaterialPageRoute(
    //       builder: (context) => const MainPage(),
    //     ),
    //   );
    // }
  }
}
