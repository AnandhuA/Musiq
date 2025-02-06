import 'dart:developer';

import 'package:hive_flutter/adapters.dart';
import 'package:musiq/models/song_model/song.dart';

class LikedSongsRepo {
//-------  add song ----
  static Future<void> addToLikedSong(Song song) async {
    try {
      final box = await Hive.box<Song>('likedSongBox');
      song.addedAt = DateTime.now();

      await box.add(song);
      log("Song added: ${song.name}");
    } catch (e) {
      log("Error: $e");
    }
  }

  // Remove song from liked songs
  static Future<void> removeFromLikedSongs(String songId) async {
    try {
      final box = await Hive.openBox<Song>('likedSongBox');

      final songIndex = box.values.toList().indexWhere((s) => s.id == songId);

      if (songIndex != -1) {
        await box.deleteAt(songIndex);
        log("Song removed from liked songs: $songId");
      } else {
        log("Song not found in liked songs: $songId");
      }
    } catch (e) {
      log("Error removing song from liked songs: $e");
    }
  }

// ------- -------
  static Future<List<Song>?> fetchLikedSong() async {
    List<Song>? lastPlayedSongs;

    try {
      final box = await Hive.box<Song>('likedSongBox');

      lastPlayedSongs = await box.values.toList()
        ..sort((a, b) => b.addedAt!.compareTo(a.addedAt!));

      log("Fetched ${lastPlayedSongs.length} last played songs.");
      return lastPlayedSongs;
    } catch (e) {
      log("Error fetching last played songs: $e");
    }

    return null;
  }

   static Future<bool> isSongLiked(String songId) async {
    try {
      final box = await Hive.openBox<Song>('likedSongBox');

      return box.values.any((song) => song.id == songId);
    } catch (e) {
      log("Error checking if song is liked: $e");
      return false;
    }
  }
}
