import 'package:hive/hive.dart';
import 'album.dart';
import 'artists.dart';
import 'download_url.dart';
import 'image.dart';

part 'song.g.dart'; // Required for Hive code generation

@HiveType(typeId: 0) // Assign a unique typeId for the Song class
class Song {
  @HiveField(0)
  String? id;

  @HiveField(1)
  String? name;

  @HiveField(2)
  String? type;

  @HiveField(3)
  String? year;

  @HiveField(4)
  String? releaseDate;

  @HiveField(5)
  int? duration;

  @HiveField(6)
  String? label;

  @HiveField(7)
  bool? explicitContent;

  @HiveField(8)
  int? playCount;

  @HiveField(9)
  String? language;

  @HiveField(10)
  bool? hasLyrics;

  @HiveField(11)
  dynamic lyricsId;

  @HiveField(12)
  String? url;

  @HiveField(13)
  String? copyright;

  @HiveField(14)
  Album? album;

  @HiveField(15)
  Artists? artists;

  @HiveField(16)
  List<Image>? image;

  @HiveField(17)
  List<DownloadUrl>? downloadUrl;

  @HiveField(18)
  DateTime? addedAt;

  Song({
    this.id,
    this.name,
    this.type,
    this.year,
    this.releaseDate,
    this.duration,
    this.label,
    this.explicitContent,
    this.playCount,
    this.language,
    this.hasLyrics,
    this.lyricsId,
    this.url,
    this.copyright,
    this.album,
    this.artists,
    this.image,
    this.downloadUrl,
    this.addedAt,
  });

  factory Song.fromJson(Map<String, dynamic> json) {
    final dynamic downloadData = json['downloadUrl'] ?? json['download_url'];
    return Song(
      id: json['id']?.toString(),
      name: json['name']?.toString(),
      type: json['type']?.toString(),
      year: json['year']?.toString(),
      releaseDate: json['releaseDate']?.toString(),
      duration: json['duration'] as int?,
      label: json['label']?.toString(),
      explicitContent: json['explicitContent'] as bool?,
      playCount: json['playCount'] as int?,
      language: json['language']?.toString(),
      hasLyrics: json['hasLyrics'] as bool?,
      lyricsId: json['lyricsId'],
      url: json['url']?.toString(),
      copyright: json['copyright']?.toString(),
      album: json['album'] is Map<String, dynamic>
          ? Album.fromJson(json['album'])
          : json['album'] is String
              ? Album(name: json['album'])
              : null,
      artists: (json['artists'] is Map<String, dynamic>)
          ? Artists.fromJson(json['artists'])
          : Artists.fromJson(json['artistMap']),
      image: (json['image'] as List<dynamic>?)
          ?.map((e) => Image.fromJson(e as Map<String, dynamic>))
          .toList(),
      downloadUrl: (downloadData as List<dynamic>?)
          ?.map((e) => DownloadUrl.fromJson(e as Map<String, dynamic>))
          .toList(),
      addedAt: json['addedAt'] != null ? DateTime.parse(json['addedAt']) : null,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'type': type,
        'year': year,
        'releaseDate': releaseDate,
        'duration': duration,
        'label': label,
        'explicitContent': explicitContent,
        'playCount': playCount,
        'language': language,
        'hasLyrics': hasLyrics,
        'lyricsId': lyricsId,
        'url': url,
        'copyright': copyright,
        'album': album?.toJson(),
        'artists': artists?.toJson(),
        'image': image?.map((e) => e.toJson()).toList(),
        'downloadUrl': downloadUrl?.map((e) => e.toJson()).toList(),
        'addedAt': addedAt?.toIso8601String(),
      };
}
