import 'dart:async';
import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:musiq/core/global_variables.dart';
import 'package:musiq/presentation/screens/splashScreen/splash_screen.dart';
import 'package:musiq/services/audio_handler.dart';
import 'package:uni_links2/uni_links.dart';



class AppInitializer {
  StreamSubscription? _linkSubscription;

  Future<void> initializeApp(BuildContext context) async {
    _initDeepLinkListener(context);
    await _audioPlayerInit();
  }

  Future<void> _audioPlayerInit() async {
   AppGlobals().audioHandler = await AudioService.init(
      builder: () => AudioPlayerHandler(),
      config: AudioServiceConfig(
        androidNotificationChannelId: 'com.example.musiq.channel.audio',
        androidNotificationChannelName: 'Music Playback',
        androidNotificationIcon: 'drawable/music',
        androidShowNotificationBadge: true,
        androidNotificationOngoing: true,
        preloadArtwork: true,
      ),
    );
  }

  void _initDeepLinkListener(BuildContext context) {
    _linkSubscription = linkStream.listen((String? link) {
      if (link != null) {
        _handleDeepLink(context, link);
      }
    });
  }

  void _handleDeepLink(BuildContext context, String link) {
    Uri uri = Uri.parse(link);
    if (uri.scheme == 'musiq' && uri.host == 'example.com') {
      if (uri.pathSegments.isNotEmpty && uri.pathSegments[0] == 'song') {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => SplashScreen()),
        );
      }
    }
  }

  void dispose() {
    _linkSubscription?.cancel();
  }
}
