import 'dart:developer';

import 'package:hive_flutter/adapters.dart';
import 'package:musiq/models/song_model.dart';

class LastPlayedRepo {
  static Future<void> addToLastPlayedSong(SongModel song) async {
    try {
      final box = Hive.box<SongModel>('lastPlayedBox');

      final existingSongIndex =
          box.values.toList().indexWhere((s) => s.id == song.id);

      if (existingSongIndex != -1) {
        await box.deleteAt(existingSongIndex);
        log("Existing song removed: ${song.title}");
      }

      SongModel newSong = SongModel(
        id: song.id,
        type: song.type,
        album: song.album,
        year: song.year,
        duration: song.duration,
        language: song.language,
        genre: song.genre,
        is320Kbps: song.is320Kbps,
        hasLyrics: song.hasLyrics,
        lyricsSnippet: song.lyricsSnippet,
        releaseDate: song.releaseDate,
        albumId: song.albumId,
        subtitle: song.subtitle,
        title: song.title,
        artist: song.artist,
        albumArtist: song.albumArtist,
        imageUrl: song.imageUrl,
        permaUrl: song.permaUrl,
        url: song.url,
        addedAt: DateTime.now(),
      );

      await box.add(newSong);
      log("Song added: ${newSong.title}");

      if (box.length > 11) {
        await box.deleteAt(0);
        log("Oldest song removed to maintain limit.");
      }
    } catch (e) {
      log("Error: $e");
    }
  }

  static Future<List<SongModel>> fetchLastPlayed() async {
    List<SongModel> lastPlayedSongs = [];

    try {
      final box = Hive.box<SongModel>('lastPlayedBox');

      lastPlayedSongs = box.values.toList()
        ..sort((a, b) => b.addedAt!.compareTo(a.addedAt!));

      log("Fetched ${lastPlayedSongs.length} last played songs.");
    } catch (e) {
      log("Error fetching last played songs: $e");
    }

    return lastPlayedSongs;
  }

  static Future<void> clearLastPlayedSongs() async {
    try {
      final box = Hive.box<SongModel>('lastPlayedBox');

      await box.clear();

      log("All last played songs cleared.");
    } catch (e) {
      log("Error clearing last played songs: $e");
    }
  }
}
