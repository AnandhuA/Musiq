import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:lottie/lottie.dart';
import 'package:musiq/core/global_variables.dart';
import 'package:musiq/data/shared_preference.dart';
import 'package:musiq/models/song_model/song.dart';
import 'package:musiq/presentation/layout/layout_page.dart';
import 'package:musiq/services/app_initializer.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // final AudioPlayerHandler _audioPlayerHandler = AudioPlayerHandler();
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
    // await SharedPreference.clearAllPreferences();

    AppGlobals().updateTheme(await SharedPreference.getTheme());
    AppGlobals().setColorIndex(await SharedPreference.getColorIndex() ?? 0);
    AppGlobals()
        .setUserLoggedInStatus(FirebaseAuth.instance.currentUser?.email);
    await Hive.initFlutter();
    try {
      await Hive.openBox<Song>('lastPlayedBox');
    } catch (e) {
      log("-------Initialization Error: $e");
      if (defaultTargetPlatform != TargetPlatform.windows) {
        Fluttertoast.showToast(msg: "Initialization Error: $e");
      }
    }
    AppInitializer().requestStoragePermission();
    if (!mounted) return;
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => const LayOutPage(),
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
