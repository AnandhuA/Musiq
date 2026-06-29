import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:musiq/data/yt_services/yt_music_data.dart';
import 'package:musiq/models/song_model/album.dart';
import 'package:musiq/models/song_model/all.dart';
import 'package:musiq/models/song_model/artists.dart';
import 'package:musiq/models/song_model/image.dart' as song_image;
import 'package:musiq/models/song_model/song.dart';

class YouTubeScraperService {
  YouTubeScraperService._();

  static final YouTubeScraperService instance = YouTubeScraperService._();

  static const _headers = {
    'User-Agent':
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 '
            '(KHTML, like Gecko) Chrome/124.0 Safari/537.36',
    'Accept-Language': 'en-US,en;q=0.9',
  };

  Future<List<Song>> searchSongs(String query, {int limit = 20}) async {
    final musicSongs = await _searchYouTubeMusicSongs(query, limit: limit);
    if (musicSongs.isNotEmpty) return musicSongs;

    try {
      final uri = Uri.https('www.youtube.com', '/results', {
        'search_query': query,
      });
      final response = await http.get(uri, headers: _headers);
      if (response.statusCode != 200) return [];

      final initialData = _extractInitialData(response.body);
      if (initialData == null) return [];

      final renderers = <Map<String, dynamic>>[];
      _collectVideoRenderers(initialData, renderers);

      final seenIds = <String>{};
      final songs = <Song>[];
      for (final renderer in renderers) {
        final song = _videoRendererToSong(renderer);
        if (song == null ||
            song.id == null ||
            seenIds.contains(song.id) ||
            !_looksLikeMusicTrack(song)) {
          continue;
        }
        seenIds.add(song.id!);
        songs.add(song);
        if (songs.length >= limit) break;
      }
      return songs;
    } catch (_) {
      return [];
    }
  }

  Future<List<Song>> _searchYouTubeMusicSongs(
    String query, {
    required int limit,
  }) async {
    try {
      final songs = await YtMusicService().searchSongs(query);
      final seenIds = <String>{};
      final filtered = <Song>[];
      for (final song in songs) {
        if (song.id == null ||
            seenIds.contains(song.id) ||
            song.type?.toLowerCase() != 'song') {
          continue;
        }
        seenIds.add(song.id!);
        filtered.add(song);
        if (filtered.length >= limit) break;
      }
      return filtered;
    } catch (_) {
      return [];
    }
  }

  Future<List<YouTubeMusicSection>> fetchHomeSections() async {
    final queries = <String, String>{
      'Trending Music': 'trending music songs',
      'Hindi Hits': 'latest hindi songs',
      'English Hits': 'top english songs',
      'Lo-Fi Mix': 'lofi music mix',
    };

    final sections = <YouTubeMusicSection>[];
    for (final entry in queries.entries) {
      final songs = await searchSongs(entry.value, limit: 15);
      if (songs.isNotEmpty) {
        sections.add(YouTubeMusicSection(title: entry.key, songs: songs));
      }
    }
    return sections;
  }

  Map<String, dynamic>? _extractInitialData(String html) {
    const marker = 'ytInitialData = ';
    final start = html.indexOf(marker);
    if (start == -1) return null;

    final jsonStart = html.indexOf('{', start + marker.length);
    if (jsonStart == -1) return null;

    var depth = 0;
    var inString = false;
    var escaping = false;

    for (var index = jsonStart; index < html.length; index++) {
      final char = html[index];
      if (inString) {
        if (escaping) {
          escaping = false;
        } else if (char == '\\') {
          escaping = true;
        } else if (char == '"') {
          inString = false;
        }
        continue;
      }

      if (char == '"') {
        inString = true;
      } else if (char == '{') {
        depth++;
      } else if (char == '}') {
        depth--;
        if (depth == 0) {
          return jsonDecode(html.substring(jsonStart, index + 1))
              as Map<String, dynamic>;
        }
      }
    }
    return null;
  }

  void _collectVideoRenderers(dynamic node, List<Map<String, dynamic>> output) {
    if (node is Map) {
      final renderer = node['videoRenderer'];
      if (renderer is Map) {
        output.add(Map<String, dynamic>.from(renderer));
      }
      for (final value in node.values) {
        _collectVideoRenderers(value, output);
      }
    } else if (node is List) {
      for (final value in node) {
        _collectVideoRenderers(value, output);
      }
    }
  }

  Song? _videoRendererToSong(Map<String, dynamic> renderer) {
    final videoId = renderer['videoId']?.toString();
    if (videoId == null || videoId.isEmpty) return null;

    final title = _textFromRuns(renderer['title']) ?? 'Unknown';
    final artistName = _textFromRuns(renderer['ownerText']) ??
        _textFromRuns(renderer['longBylineText']) ??
        'YouTube';
    final thumbnail = _thumbnailFromRenderer(renderer, videoId);
    final duration = _durationFromText(_textFromRuns(renderer['lengthText']));

    return Song(
      id: videoId,
      name: title,
      type: 'song',
      duration: duration,
      label: artistName,
      language: 'YouTube',
      url: 'https://www.youtube.com/watch?v=$videoId',
      album: Album(name: 'YouTube'),
      artists: Artists(
        all: [
          All(
            name: artistName,
            role: 'artist',
            type: 'artist',
          ),
        ],
      ),
      image: [
        song_image.Image(imageUrl: thumbnail, quality: 'high'),
      ],
    );
  }

  bool _looksLikeMusicTrack(Song song) {
    final duration = song.duration ?? 0;
    if (duration == 0 || duration > 10 * 60) return false;

    final title = (song.name ?? '').toLowerCase();
    final artist = (song.label ?? '').toLowerCase();
    const blockedWords = [
      'reaction',
      'review',
      'trailer',
      'interview',
      'podcast',
      'news',
      'live stream',
      'full movie',
    ];
    return !blockedWords.any(
      (word) => title.contains(word) || artist.contains(word),
    );
  }

  String? _textFromRuns(dynamic value) {
    if (value is! Map) return null;
    final simpleText = value['simpleText']?.toString();
    if (simpleText != null && simpleText.isNotEmpty) return simpleText;

    final runs = value['runs'];
    if (runs is! List) return null;
    final text = runs
        .map((run) => run is Map ? run['text']?.toString() ?? '' : '')
        .join()
        .trim();
    return text.isEmpty ? null : text;
  }

  String _thumbnailFromRenderer(Map<String, dynamic> renderer, String videoId) {
    final thumbnails = renderer['thumbnail']?['thumbnails'];
    if (thumbnails is List && thumbnails.isNotEmpty) {
      final url = thumbnails.last['url']?.toString();
      if (url != null && url.isNotEmpty) {
        return url.startsWith('//') ? 'https:$url' : url;
      }
    }
    return 'https://i.ytimg.com/vi/$videoId/hqdefault.jpg';
  }

  int? _durationFromText(String? duration) {
    if (duration == null || duration.isEmpty) return null;
    final parts = duration.split(':').map(int.tryParse).toList();
    if (parts.any((part) => part == null)) return null;

    var seconds = 0;
    for (final part in parts) {
      seconds = (seconds * 60) + part!;
    }
    return seconds;
  }
}

class YouTubeMusicSection {
  final String title;
  final List<Song> songs;

  const YouTubeMusicSection({
    required this.title,
    required this.songs,
  });
}
