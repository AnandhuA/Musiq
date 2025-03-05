import 'dart:developer';

import 'package:hive_flutter/adapters.dart';
import 'package:musiq/models/song_model/song.dart';

class HistoryRepo {
//-------  add last played song in hive local data base----
  static Future<void> addToLastPlayedSong(Song song) async {
    try {
      final box = await Hive.box<Song>('lastPlayedBox');

     
      final existingSongIndex =
          box.values.toList().indexWhere((s) => s.id == song.id);

      if (existingSongIndex != -1) {
        final existingSong = box.getAt(existingSongIndex);

        if (existingSong != null) {
          existingSong.localPlayCount += 1; 
          existingSong.addedAt = DateTime.now(); 

          await box.putAt(existingSongIndex, existingSong);
          log("Updated local play count: ${existingSong.name}, Count: ${existingSong.localPlayCount}");
          return;
        }
      }


      song.localPlayCount = 1;
      song.addedAt = DateTime.now();

      await box.add(song);
      log("New song added: ${song.name}, Local Play Count: ${song.localPlayCount}");
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


  static Future<Song?> findMostPlayedSong() async {
  try {
    final box = await Hive.box<Song>('lastPlayedBox');

    if (box.isEmpty) {
      log("No songs in history.");
      return null;
    }

    Song? mostPlayedSong = box.values.reduce((a, b) =>
        (a.localPlayCount) > (b.localPlayCount) ? a : b);
    
    log("Most played song: ${mostPlayedSong.name} (Played: ${mostPlayedSong.localPlayCount} times)");
    return mostPlayedSong;
  } catch (e) {
    log("Error finding most played song: $e");
    return null;
  }
}


}
