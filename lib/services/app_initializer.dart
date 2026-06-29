import 'package:audio_service/audio_service.dart';
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
import 'package:musiq/services/audio_handler.dart';

class AppInitializer {
  Future<void> initializeApp() async {
    await Hive.initFlutter();
    await _registerHiveAdapters();
    await _openHiveBoxes();
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

  Future<void> _openHiveBoxes() async {
    await Hive.openBox<Song>('lastPlayedBox');
    await Hive.openBox<Song>('likedSongBox');
    await Hive.openBox<String>('search_history');
    await Hive.openBox('settings');
    await Hive.openBox('ytlinkcache');
  }
}
