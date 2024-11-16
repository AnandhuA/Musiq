import 'dart:developer';

import 'package:hive_flutter/adapters.dart';
import 'package:musiq/models/song_model/song.dart';

class LastPlayedRepo {
//-------  add last played song in hive local data base----
  static Future<void> addToLastPlayedSong(Song song) async {
    try {
      final box = await Hive.box<Song>('lastPlayedBox');

      final existingSongIndex =
          box.values.toList().indexWhere((s) => s.id == song.id);

      if (existingSongIndex != -1) {
        await box.deleteAt(existingSongIndex);
        log("Existing song removed: ${song.name}");
      }

      song.addedAt = DateTime.now();

      await box.add(song);
      log("Song added: ${song.name}");
      if (box.length > 18) {
        await box.deleteAt(0);
        log("Oldest song removed to maintain limit.");
      }
    } catch (e) {
      log("Error: $e");
    }
  }

// -------  last played song fron hive data base -------
  static Future<List<Song>?> fetchLastPlayed() async {
    List<Song>? lastPlayedSongs;

    try {
      final box = await Hive.box<Song>('lastPlayedBox');

      lastPlayedSongs = await box.values.toList()
        ..sort((a, b) => b.addedAt!.compareTo(a.addedAt!));

      log("Fetched ${lastPlayedSongs.length} last played songs.");
      return lastPlayedSongs;
    } catch (e) {
      log("Error fetching last played songs: $e");
    }

    return null;
  }

//---- clear last played section --------
  static Future<void> clearLastPlayedSongs() async {
    try {
      final box = await Hive.box<Song>('lastPlayedBox');

      await box.clear();
      log("All last played songs cleared.");
    } catch (e) {
      log("Error clearing last played songs: $e");
    }
  }
}
