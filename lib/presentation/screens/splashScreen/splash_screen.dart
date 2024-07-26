import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

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
    await Future.delayed(const Duration(seconds: 2));
    // final firebaseAuth = FirebaseAuth.instance;
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const MainPage(),
      ),
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
