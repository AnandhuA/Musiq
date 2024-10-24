import 'package:musiq/models/global_search_model/result.dart';

class Playlists {
   List<Result>? results;
  int? position;

  Playlists({this.results, this.position});

  factory Playlists.fromJson(Map<String, dynamic> json) => Playlists(
        results: (json['results'] as List<dynamic>?) ?.map((e) => Result.fromJson(e as Map<String, dynamic>))
            .toList(),
        position: json['position'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'results': results,
        'position': position,
      };
}
