class Song {
  String id;
  String name;
  String type;
  String year;
  String releaseDate;
  int duration;
  String label;
  bool explicitContent;
  int playCount;
  String language;
  bool hasLyrics;
  String? lyricsId;
  String url;
  String copyright;
  Album album;
  Artists artists;
  List<ImageList> image;
  List<DownloadUrl> downloadUrl;

  Song({
    required this.id,
    required this.name,
    required this.type,
    required this.year,
    required this.releaseDate,
    required this.duration,
    required this.label,
    required this.explicitContent,
    required this.playCount,
    required this.language,
    required this.hasLyrics,
    this.lyricsId,
    required this.url,
    required this.copyright,
    required this.album,
    required this.artists,
    required this.image,
    required this.downloadUrl,
  });

  factory Song.fromJson(Map<String, dynamic> json) {
    return Song(
      id: json['id'],
      name: json['name'],
      type: json['type'],
      year: json['year'],
      releaseDate: json['releaseDate'],
      duration: json['duration'],
      label: json['label'],
      explicitContent: json['explicitContent'],
      playCount: json['playCount'],
      language: json['language'],
      hasLyrics: json['hasLyrics'],
      lyricsId: json['lyricsId'],
      url: json['url'],
      copyright: json['copyright'],
      album: Album.fromJson(json['album']),
      artists: Artists.fromJson(json['artists']),
      image: List<ImageList>.from(json['image'].map((x) => ImageList.fromJson(x))),
      downloadUrl: List<DownloadUrl>.from(
          json['downloadUrl'].map((x) => DownloadUrl.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() {
    return {
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
      'album': album.toJson(),
      'artists': artists.toJson(),
      'image': List<dynamic>.from(image.map((x) => x.toJson())),
      'downloadUrl': List<dynamic>.from(downloadUrl.map((x) => x.toJson())),
    };
  }
}

class Album {
  String id;
  String name;
  String url;

  Album({
    required this.id,
    required this.name,
    required this.url,
  });

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      id: json['id'],
      name: json['name'],
      url: json['url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'url': url,
    };
  }
}

class Artists {
  List<Artist> primary;
  List<dynamic> featured;
  List<Artist> all;

  Artists({
    required this.primary,
    required this.featured,
    required this.all,
  });

  factory Artists.fromJson(Map<String, dynamic> json) {
    return Artists(
      primary:
          List<Artist>.from(json['primary'].map((x) => Artist.fromJson(x))),
      featured: List<dynamic>.from(json['featured'].map((x) => x)),
      all: List<Artist>.from(json['all'].map((x) => Artist.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'primary': List<dynamic>.from(primary.map((x) => x.toJson())),
      'featured': List<dynamic>.from(featured.map((x) => x)),
      'all': List<dynamic>.from(all.map((x) => x.toJson())),
    };
  }
}

class Artist {
  String id;
  String name;
  String role;
  List<ImageList> image;
  String type;
  String url;

  Artist({
    required this.id,
    required this.name,
    required this.role,
    required this.image,
    required this.type,
    required this.url,
  });

  factory Artist.fromJson(Map<String, dynamic> json) {
    return Artist(
      id: json['id'],
      name: json['name'],
      role: json['role'],
      image: List<ImageList>.from(json['image'].map((x) => ImageList.fromJson(x))),
      type: json['type'],
      url: json['url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'role': role,
      'image': List<dynamic>.from(image.map((x) => x.toJson())),
      'type': type,
      'url': url,
    };
  }
}

class ImageList {
  String quality;
  String url;

  ImageList({
    required this.quality,
    required this.url,
  });

  factory ImageList.fromJson(Map<String, dynamic> json) {
    return ImageList(
      quality: json['quality'],
      url: json['url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'quality': quality,
      'url': url,
    };
  }
}

class DownloadUrl {
  String quality;
  String url;

  DownloadUrl({
    required this.quality,
    required this.url,
  });

  factory DownloadUrl.fromJson(Map<String, dynamic> json) {
    return DownloadUrl(
      quality: json['quality'],
      url: json['url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'quality': quality,
      'url': url,
    };
  }
}
