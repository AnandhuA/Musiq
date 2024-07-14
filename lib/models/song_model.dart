
import 'dart:typed_data';

class SongModel {
  final String songUrls;
  final String album;
  final Duration duration;
  final String artist;
  final Uint8List? imgFile;

  SongModel({
    required this.songUrls,
    required this.album,
    required this.duration,
    required this.artist,
    required this.imgFile,
  });
}
