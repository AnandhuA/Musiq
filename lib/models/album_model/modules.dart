import 'artists.dart';
import 'currently_trending.dart';
import 'recommend.dart';
import 'top_albums_from_same_year.dart';

class Modules {
  Artists? artists;
  CurrentlyTrending? currentlyTrending;
  Recommend? recommend;
  TopAlbumsFromSameYear? topAlbumsFromSameYear;

  Modules({
    this.artists,
    this.currentlyTrending,
    this.recommend,
    this.topAlbumsFromSameYear,
  });

  factory Modules.fromJson(Map<String, dynamic> json) => Modules(
        artists: json['artists'] == null
            ? null
            : Artists.fromJson(json['artists'] as Map<String, dynamic>),
        currentlyTrending: json['currently_trending'] == null
            ? null
            : CurrentlyTrending.fromJson(
                json['currently_trending'] as Map<String, dynamic>),
        recommend: json['recommend'] == null
            ? null
            : Recommend.fromJson(json['recommend'] as Map<String, dynamic>),
        topAlbumsFromSameYear: json['top_albums_from_same_year'] == null
            ? null
            : TopAlbumsFromSameYear.fromJson(
                json['top_albums_from_same_year'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'artists': artists?.toJson(),
        'currently_trending': currentlyTrending?.toJson(),
        'recommend': recommend?.toJson(),
        'top_albums_from_same_year': topAlbumsFromSameYear?.toJson(),
      };
}
