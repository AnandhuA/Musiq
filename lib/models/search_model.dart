import 'package:musiq/models/song_model.dart';

class SearchModel {
  final List<Album>? albums;
  final List<Playlist>? playlists;
  final List<Artist>? artists;
  final List<SongModel>? songs;
  final Map<dynamic, String>? categories;

  SearchModel({
    this.albums,
    this.playlists,
    this.artists,
    this.songs,
    this.categories,
  });

  factory SearchModel.fromJson(List<dynamic> json) {
    return SearchModel(
      albums: json[0]['Albums'] != null
          ? List<Album>.from(json[0]['Albums'].map((x) => Album.fromJson(x)))
          : null,
      playlists: json[0]['Playlists'] != null
          ? List<Playlist>.from(
              json[0]['Playlists'].map((x) => Playlist.fromJson(x)))
          : null,
      artists: json[0]['Artists'] != null
          ? List<Artist>.from(json[0]['Artists'].map((x) => Artist.fromJson(x)))
          : null,
      songs: json[0]['Songs'] != null
          ? List<SongModel>.from(
              json[0]['Songs'].map((x) => SongModel.fromJson(x)))
          : null,
      categories: json[1] != null
          ? Map<String, String>.from(
              json[1].map((key, value) => MapEntry(key.toString(), value)))
          : null,
    );
  }

  Map<dynamic, dynamic> toJson() {
    return {
      'Albums': albums?.map((album) => album.toJson()).toList(),
      'Playlists': playlists?.map((playlist) => playlist.toJson()).toList(),
      'Artists': artists?.map((artist) => artist.toJson()).toList(),
      'Songs': songs?.map((song) => song.toJson()).toList(),
      'Categories': categories,
    };
  }
}

class Album {
  final String id;
  final String type;
  final String album;
  final String year;
  final String language;
  final String genre;
  final String albumId;
  final String subtitle;
  final String title;
  final String artist;
  final String? albumArtist;
  final String image;
  final String count;
  final List<String> songsPids;
  final String permaUrl;

  Album({
    required this.id,
    required this.type,
    required this.album,
    required this.year,
    required this.language,
    required this.genre,
    required this.albumId,
    required this.subtitle,
    required this.title,
    required this.artist,
    this.albumArtist,
    required this.image,
    required this.count,
    required this.songsPids,
    required this.permaUrl,
  });

  factory Album.fromJson(Map<dynamic, dynamic> json) {
    return Album(
      id: json['id'].toString(),
      type: json['type'].toString(),
      album: json['album'].toString(),
      year: json['year'].toString(),
      language: json['language'].toString(),
      genre: json['genre'].toString(),
      albumId: json['album_id'].toString(),
      subtitle: json['subtitle'].toString(),
      title: json['title'].toString(),
      artist: json['artist'].toString(),
      albumArtist: json['album_artist'].toString(),
      image: json['image'].toString(),
      count: json['count'].toString(),
      songsPids: List<String>.from(json['songs_pids']),
      permaUrl: json['perma_url'].toString(),
    );
  }

  Map<dynamic, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'album': album,
      'year': year,
      'language': language,
      'genre': genre,
      'album_id': albumId,
      'subtitle': subtitle,
      'title': title,
      'artist': artist,
      'album_artist': albumArtist,
      'image': image,
      'count': count,
      'songs_pids': songsPids,
      'perma_url': permaUrl,
    };
  }
}

class Playlist {
  final String id;
  final String type;
  final String album;
  final String language;
  final String genre;
  final String playlistId;
  final String subtitle;
  final String title;
  final String artist;
  final String? albumArtist;
  final String image;
  final String permaUrl;

  Playlist({
    required this.id,
    required this.type,
    required this.album,
    required this.language,
    required this.genre,
    required this.playlistId,
    required this.subtitle,
    required this.title,
    required this.artist,
    this.albumArtist,
    required this.image,
    required this.permaUrl,
  });

  factory Playlist.fromJson(Map<dynamic, dynamic> json) {
    return Playlist(
      id: json['id'].toString(),
      type: json['type'].toString(),
      album: json['album'].toString(),
      language: json['language'].toString(),
      genre: json['genre'].toString(),
      playlistId: json['playlistId'].toString(),
      subtitle: json['subtitle'].toString(),
      title: json['title'].toString(),
      artist: json['artist'].toString(),
      albumArtist: json['album_artist'].toString(),
      image: json['image'].toString(),
      permaUrl: json['perma_url'].toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'album': album,
      'language': language,
      'genre': genre,
      'playlistId': playlistId,
      'subtitle': subtitle,
      'title': title,
      'artist': artist,
      'album_artist': albumArtist,
      'image': image,
      'perma_url': permaUrl,
    };
  }
}

class Artist {
  final String id;
  final String type;
  final String album;
  final String artistId;
  final String artistToken;
  final String subtitle;
  final String title;
  final String permaUrl;
  final String artist;
  final String? albumArtist;
  final String image;

  Artist({
    required this.id,
    required this.type,
    required this.album,
    required this.artistId,
    required this.artistToken,
    required this.subtitle,
    required this.title,
    required this.permaUrl,
    required this.artist,
    this.albumArtist,
    required this.image,
  });

  factory Artist.fromJson(Map<dynamic, dynamic> json) {
    return Artist(
      id: json['id'].toString(),
      type: json['type'].toString(),
      album: json['album'].toString(),
      artistId: json['artistId'].toString(),
      artistToken: json['artistToken'].toString(),
      subtitle: json['subtitle'].toString(),
      title: json['title'].toString(),
      permaUrl: json['perma_url'].toString(),
      artist: json['artist'].toString(),
      albumArtist: json['album_artist'].toString(),
      image: json['image'].toString(),
    );
  }

  Map<dynamic, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'album': album,
      'artistId': artistId,
      'artistToken': artistToken,
      'subtitle': subtitle,
      'title': title,
      'perma_url': permaUrl,
      'artist': artist,
      'album_artist': albumArtist,
      'image': image,
    };
  }
}
