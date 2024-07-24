import 'dart:developer';

class SearchResponse {
  final bool success;
  final Data data;

  SearchResponse({
    required this.success,
    required this.data,
  });

  factory SearchResponse.fromJson(Map<String, dynamic> json) {
    return SearchResponse(
      success: json['success'] ?? false,
      data: Data.fromJson(json['data'] ?? {}),
    );
  }
}

class Data {
  final QueryResult topQuery;
  final QueryResult songs;
  final QueryResult albums;
  final QueryResult artists;
  final QueryResult playlists;

  Data({
    required this.topQuery,
    required this.songs,
    required this.albums,
    required this.artists,
    required this.playlists,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      topQuery: QueryResult.fromJson(json['topQuery'] ?? {}),
      songs: QueryResult.fromJson(json['songs'] ?? {}),
      albums: QueryResult.fromJson(json['albums'] ?? {}),
      artists: QueryResult.fromJson(json['artists'] ?? {}),
      playlists: QueryResult.fromJson(json['playlists'] ?? {}),
    );
  }
}

class QueryResult {
  final List<Result> results;
  final int position;

  QueryResult({
    required this.results,
    required this.position,
  });

  factory QueryResult.fromJson(Map<String, dynamic> json) {
    var list = json['results'];
    List<Result> resultsList = [];

    if (list is List) {
      resultsList = list.map((i) => Result.fromJson(i)).toList();
    } else {
      resultsList = [];
      log('Expected a list for "results", but got: ${list.runtimeType}');
    }

    return QueryResult(
      results: resultsList,
      position: json['position'] ?? 0,
    );
  }
}

class Result {
  final String? id;
  final String? title;
  final List<ImageQuality>? image;
  final String? album;
  final String? url;
  final String? type;
  final String? description;
  final String? primaryArtists;
  final String? singers;
  final String? language;
  final String? year;
  final List<String>? songIds;
  final String? artist;

  Result({
    this.id,
    this.title,
    this.image,
    this.album,
    this.url,
    this.type,
    this.description,
    this.primaryArtists,
    this.singers,
    this.language,
    this.year,
    this.songIds,
    this.artist,
  });

  factory Result.fromJson(Map<String, dynamic> json) {
    var imageList = json['image'];
    List<ImageQuality> images = [];

    if (imageList is List) {
      images = imageList.map((i) => ImageQuality.fromJson(i)).toList();
    } else {
      print('Expected a list for "image", but got: ${imageList.runtimeType}');
    }

    return Result(
      id: json['id'],
      title: json['title'],
      image: images,
      album: json['album'],
      url: json['url'],
      type: json['type'],
      description: json['description'],
      primaryArtists: json['primaryArtists'],
      singers: json['singers'],
      language: json['language'],
      year: json['year'],
      songIds: (json['songIds'] as List<dynamic>?)
          ?.map((item) => item as String)
          .toList(),
      artist: json['artist'],
    );
  }
}

class ImageQuality {
  final String quality;
  final String url;

  ImageQuality({
    required this.quality,
    required this.url,
  });

  factory ImageQuality.fromJson(Map<String, dynamic> json) {
    return ImageQuality(
      quality: json['quality'] ?? '',
      url: json['url'] ?? '',
    );
  }
}
