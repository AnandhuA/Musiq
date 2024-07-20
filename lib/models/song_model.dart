import 'dart:typed_data';

class SongModel {
  final String songUrls;
  final String movie;
  final String songName;
  final String lyrics;
  final String language;
  final Duration duration;
  final String artist;
   Uint8List? imgFile;

  SongModel({
    required this.songUrls,
    required this.movie,
    required this.songName,
    required this.duration,
    required this.artist,
    required this.imgFile,
    required this.lyrics,
    required this.language,
  });
}
