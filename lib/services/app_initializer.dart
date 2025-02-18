import 'dart:async';
import 'dart:developer';
import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:musiq/core/global_variables.dart';
import 'package:musiq/models/playlist_model_hive/playlist_model.dart';
import 'package:musiq/models/song_model/album.dart';
import 'package:musiq/models/song_model/all.dart';
import 'package:musiq/models/song_model/artists.dart';
import 'package:musiq/models/song_model/download_url.dart';
import 'package:musiq/models/song_model/image.dart';
import 'package:musiq/models/song_model/primary.dart';
import 'package:musiq/models/song_model/song.dart';
import 'package:musiq/presentation/screens/splashScreen/splash_screen.dart';
import 'package:musiq/services/audio_handler.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:uni_links2/uni_links.dart';

class AppInitializer {
  StreamSubscription? _linkSubscription;

  Future<void> initializeApp() async {
    await _registerHiveAdapters();

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

  void initDeepLinkListener(BuildContext context) {
    _linkSubscription = linkStream.listen((String? link) {
      if (link != null) {
        _handleDeepLink(context, link);
      }
    });
  }

  _registerHiveAdapters() async {
    if (!Hive.isAdapterRegistered(SongAdapter().typeId)) {
      Hive.registerAdapter(SongAdapter());
    }
    if (!Hive.isAdapterRegistered(ImageAdapter().typeId)) {
      Hive.registerAdapter(ImageAdapter());
    }
    if (!Hive.isAdapterRegistered(DownloadUrlAdapter().typeId)) {
      Hive.registerAdapter(DownloadUrlAdapter());
    }
    if (!Hive.isAdapterRegistered(ArtistsAdapter().typeId)) {
      Hive.registerAdapter(ArtistsAdapter());
    }
    if (!Hive.isAdapterRegistered(AlbumAdapter().typeId)) {
      Hive.registerAdapter(AlbumAdapter());
    }
    if (!Hive.isAdapterRegistered(PrimaryAdapter().typeId)) {
      Hive.registerAdapter(PrimaryAdapter());
    }
    if (!Hive.isAdapterRegistered(AllAdapter().typeId)) {
      Hive.registerAdapter(AllAdapter());
    }
    if (!Hive.isAdapterRegistered(PlaylistModelHiveAdapter().typeId)) {
      Hive.registerAdapter(PlaylistModelHiveAdapter());
    }
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

  Future<void> requestStoragePermission() async {
    log("------------permission-----------");

    var status = await Permission.storage.status;
    var videostatus = await Permission.videos.request();
    log("--Current Permission Status: $status::$videostatus");

    if (!status.isGranted) {
      log("--Requesting storage permission...");
      await Permission.storage.request();
      status = await Permission.storage.status;
      log("--New Permission Status: $status");
    } else {
      log("---Storage permission already granted");
    }
  }
}
