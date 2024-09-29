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
  // final AudioPlayerHandler _audioPlayerHandler = AudioPlayerHandler();
  @override
  void initState() {
    super.initState();
    // _initMediaItems();
    _startApp();
  }

  // void _initMediaItems() async {
  //   List<MediaItem> mediaItems = [
  //     MediaItem(
  //       id: 'https://www.example.com/audio1.mp3',
  //       title: 'Audio 1',
  //       artist: 'Artist 1',
  //       album: 'Album 1',
  //       duration: Duration(minutes: 3),
  //     ),
  //     MediaItem(
  //       id: 'https://www.example.com/audio2.mp3',
  //       title: 'Audio 2',
  //       artist: 'Artist 2',
  //       album: 'Album 2',
  //       duration: Duration(minutes: 4),
  //     ),
  //   ];

  //   await _audioPlayerHandler.setMediaItems(mediaItems);
  // }

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
    theme = await SharedPreference.getTheme();
    colorIndex = await SharedPreference.getColorIndex() ?? 0;
    lastplayed = await SharedPreference.getLastPlayedSong();
    userIsLoggedIn = FirebaseAuth.instance.currentUser?.email;

    log("$userIsLoggedIn");
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
