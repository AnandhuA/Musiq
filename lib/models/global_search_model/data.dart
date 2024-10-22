import 'albums.dart';
import 'artists.dart';
import 'playlists.dart';
import 'songs.dart';
import 'top_query.dart';

class Data {
  TopQuery? topQuery;
  Songs? songs;
  Albums? albums;
  Artists? artists;
  Playlists? playlists;

  Data({
    this.topQuery,
    this.songs,
    this.albums,
    this.artists,
    this.playlists,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        topQuery: json['topQuery'] == null
            ? null
            : TopQuery.fromJson(json['topQuery'] as Map<String, dynamic>),
        songs: json['songs'] == null
            ? null
            : Songs.fromJson(json['songs'] as Map<String, dynamic>),
        albums: json['albums'] == null
            ? null
            : Albums.fromJson(json['albums'] as Map<String, dynamic>),
        artists: json['artists'] == null
            ? null
            : Artists.fromJson(json['artists'] as Map<String, dynamic>),
        playlists: json['playlists'] == null
            ? null
            : Playlists.fromJson(json['playlists'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'topQuery': topQuery?.toJson(),
        'songs': songs?.toJson(),
        'albums': albums?.toJson(),
        'artists': artists?.toJson(),
        'playlists': playlists?.toJson(),
      };
}
