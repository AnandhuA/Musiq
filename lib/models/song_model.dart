
import 'package:hive/hive.dart';

part 'song_model.g.dart'; // Generated adapter file

@HiveType(typeId: 1)
class SongModel extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String type;

  @HiveField(2)
  final String album;

  @HiveField(3)
  final int year;

  @HiveField(4)
  final int duration;

  @HiveField(5)
  final String language;

  @HiveField(6)
  final String genre;

  @HiveField(7)
  final bool is320Kbps;

  @HiveField(8)
  final bool hasLyrics;

  @HiveField(9)
  final String lyricsSnippet;

  @HiveField(10)
  final String releaseDate;

  @HiveField(11)
  final String albumId;

  @HiveField(12)
  final String subtitle;

  @HiveField(13)
  final String title;

  @HiveField(14)
  final String artist;

  @HiveField(15)
  final String albumArtist;

  @HiveField(16)
  final String imageUrl;

  @HiveField(17)
  final String permaUrl;

  @HiveField(18)
  final String url;

  @HiveField(19)
  final DateTime? addedAt; // Nullable addedAt field

  SongModel({
    required this.id,
    required this.type,
    required this.album,
    required this.year,
    required this.duration,
    required this.language,
    required this.genre,
    required this.is320Kbps,
    required this.hasLyrics,
    required this.lyricsSnippet,
    required this.releaseDate,
    required this.albumId,
    required this.subtitle,
    required this.title,
    required this.artist,
    required this.albumArtist,
    required this.imageUrl,
    required this.permaUrl,
    required this.url,
    this.addedAt, // Initialize as nullable
  });

  // Conversion to and from JSON is optional when using Hive, but here's your previous methods for reference.

  factory SongModel.fromJson(Map<dynamic, dynamic> json) {
    return SongModel(
      id: json['id'] as String? ?? '',
      type: json['type'] as String? ?? '',
      album: json['album'] as String? ?? '',
      year: int.tryParse(json['year'].toString()) ?? 0,
      duration: int.tryParse(json['duration'].toString()) ?? 0,
      language: json['language'] as String? ?? '',
      genre: json['genre'] as String? ?? '',
      is320Kbps: json['320kbps'] is String
          ? json['320kbps'].toLowerCase() == 'true'
          : json['320kbps'] ?? false,
      hasLyrics: json['has_lyrics'] is String
          ? json['has_lyrics'].toLowerCase() == 'true'
          : json['has_lyrics'] ?? false,
      lyricsSnippet: json['lyrics_snippet'] as String? ?? '',
      releaseDate: json['release_date'] as String? ?? '',
      albumId: json['album_id'] as String? ?? '',
      subtitle: json['subtitle'] as String? ?? '',
      title: json['title'] as String? ?? '',
      artist: json['artist'] as String? ?? '',
      albumArtist: json['album_artist'] as String? ?? '',
      imageUrl: json['image'] as String? ?? '',
      permaUrl: json['perma_url'] as String? ?? '',
      url: json['url'] as String? ?? '',
      addedAt:
          json['added_at'] != null ? DateTime.parse(json['added_at']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'album': album,
      'year': year,
      'duration': duration,
      'language': language,
      'genre': genre,
      '320kbps': is320Kbps,
      'has_lyrics': hasLyrics,
      'lyrics_snippet': lyricsSnippet,
      'release_date': releaseDate,
      'album_id': albumId,
      'subtitle': subtitle,
      'title': title,
      'artist': artist,
      'album_artist': albumArtist,
      'image': imageUrl,
      'perma_url': permaUrl,
      'url': url,
      'added_at': addedAt?.toIso8601String(), // Convert DateTime to ISO String
    };
  }
}
