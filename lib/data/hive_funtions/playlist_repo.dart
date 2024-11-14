import 'dart:developer';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:musiq/models/playlist_model_hive/playlist_model.dart';
import 'package:musiq/models/song_model/song.dart';

class PlaylistRepo {
  static const String playlistBoxName = 'playlistBox';

  static Future<void> addPlaylist(PlaylistModelHive playlist) async {
    try {
      final box = await Hive.openBox<PlaylistModelHive>(playlistBoxName);

      if (box.containsKey(playlist.name)) {
        Fluttertoast.showToast(
            msg: "Playlist '${playlist.name}' already exists");
      } else {
        await box.put(playlist.name, playlist);
        log("Playlist added: ${playlist.name}");
        Fluttertoast.showToast(msg: "Playlist added: ${playlist.name}");
      }
    } catch (e) {
      log("Error adding playlist: $e");
      Fluttertoast.showToast(msg: "Error adding playlist: $e");
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
      Fluttertoast.showToast(msg: "Error fetching playlists: $e");
      return [];
    }
  }

  static Future<void> addSongToPlaylist(String playlistName, Song song) async {
    try {
      final box = await Hive.openBox<PlaylistModelHive>(playlistBoxName);
      final playlist = box.get(playlistName);

      if (playlist != null) {
        if (!playlist.songList.any((s) => s.id == song.id)) {
          playlist.songList.add(song);
          await box.put(playlistName, playlist);
          log("Song added to playlist: ${playlist.name}");
          Fluttertoast.showToast(
              msg: "Song added to playlist: ${playlist.name}");
        } else {
          Fluttertoast.showToast(msg: "Song already in playlist");
        }
      } else {
        Fluttertoast.showToast(msg: "Playlist not found");
      }
    } catch (e) {
      log("Error adding song to playlist: $e");
      Fluttertoast.showToast(msg: "Error adding song to playlist: $e");
    }
  }

  static Future<void> removeSongFromPlaylist(
      String playlistName, Song song) async {
    try {
      final box = await Hive.openBox<PlaylistModelHive>(playlistBoxName);
      final playlist = box.get(playlistName);

      if (playlist != null) {
        playlist.songList.removeWhere((s) => s.id == song.id);
        await box.put(playlistName, playlist);
        log("Song removed from playlist: ${playlist.name}");
        Fluttertoast.showToast(
            msg: "Song removed from playlist: ${playlist.name}");
      } else {
        Fluttertoast.showToast(msg: "Playlist not found");
      }
    } catch (e) {
      log("Error removing song from playlist: $e");
      Fluttertoast.showToast(msg: "Error removing song from playlist: $e");
    }
  }

  static Future<void> clearPlaylists() async {
    try {
      final box = await Hive.openBox<PlaylistModelHive>(playlistBoxName);
      await box.clear();
      log("All playlists cleared.");
      Fluttertoast.showToast(msg: "All playlists cleared.");
    } catch (e) {
      log("Error clearing playlists: $e");
      Fluttertoast.showToast(msg: "Error clearing playlists: $e");
    }
  }
}
