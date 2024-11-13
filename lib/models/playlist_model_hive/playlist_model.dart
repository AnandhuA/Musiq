import 'package:hive_flutter/hive_flutter.dart';
import 'package:musiq/models/song_model/song.dart';
part 'playlist_model.g.dart';

@HiveType(typeId: 7)
class PlaylistModelHive {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final List<Song> songList;
  @HiveField(3)
  final String? imagePath;

  PlaylistModelHive({
    required this.id,
    required this.name,
    required this.songList,
    this.imagePath,
  });
}
