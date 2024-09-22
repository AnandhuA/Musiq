class SongModel {
  final String id;
  final String type;
  final String album;
  final int year;
  final int duration;
  final String language;
  final String genre;
  final bool is320Kbps;
  final bool hasLyrics;
  final String lyricsSnippet;
  final String releaseDate;
  final String albumId;
  final String subtitle;
  final String title;
  final String artist;
  final String albumArtist;
  final String imageUrl;
  final String permaUrl;
  final String url;
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
