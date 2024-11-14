import 'package:hive_flutter/hive_flutter.dart';
import 'package:musiq/models/song_model/song.dart';
part 'playlist_model.g.dart';

@HiveType(typeId: 7)
class PlaylistModelHive {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final List<Song> songList;
  @HiveField(2)
  final String? imagePath;

  PlaylistModelHive({
    required this.name,
    required this.songList,
    this.imagePath,
  });
}
