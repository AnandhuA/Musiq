import 'dart:developer';

import 'package:hive_flutter/adapters.dart';
import 'package:musiq/models/playlist_model_hive/playlist_model.dart';
import 'package:musiq/models/song_model/song.dart';

class PlaylistRepo {
  static const String playlistBoxName = 'playlistBox';

  static Future<void> addPlaylist(PlaylistModelHive playlist) async {
    try {
      final box = await Hive.openBox<PlaylistModelHive>(playlistBoxName);

      if (box.values.any((p) => p.id == playlist.id)) {
        log("Playlist with ID ${playlist.id} already exists.");
      } else {
        await box.add(playlist);
        log("Playlist added: ${playlist.name}");
      }
    } catch (e) {
      log("Error adding playlist: $e");
    }
  }

  static Future<List<PlaylistModelHive>> fetchPlaylists() async {
    try {
      final box = await Hive.openBox<PlaylistModelHive>(playlistBoxName);
      List<PlaylistModelHive> playlists = box.values.toList();
      log("Fetched ${playlists.length} playlists.");
      return playlists;
    } catch (e) {
      log("Error fetching playlists: $e");
      return [];
    }
  }

  static Future<void> addSongToPlaylist(int playlistId, Song song) async {
    try {
      final box = await Hive.openBox<PlaylistModelHive>(playlistBoxName);

      final playlist = box.values.firstWhere((p) => p.id == playlistId);

      if (!playlist.songList.any((s) => s.id == song.id)) {
        playlist.songList.add(song);
        await box.put(playlistId, playlist);
        log("Song added to playlist: ${playlist.name}");
      }
    } catch (e) {
      log("Error adding song to playlist: $e");
    }
  }

  static Future<void> removeSongFromPlaylist(int playlistId, Song song) async {
    try {
      final box = await Hive.openBox<PlaylistModelHive>(playlistBoxName);

      final playlist = box.values.firstWhere((p) => p.id == playlistId);

      playlist.songList.removeWhere((s) => s.id == song.id);
      await box.put(playlistId, playlist);
      log("Song removed from playlist: ${playlist.name}");
    } catch (e) {
      log("Error removing song from playlist: $e");
    }
  }

  static Future<void> clearPlaylists() async {
    try {
      final box = await Hive.openBox<PlaylistModelHive>(playlistBoxName);
      await box.clear();
      log("All playlists cleared.");
    } catch (e) {
      log("Error clearing playlists: $e");
    }
  }
}
