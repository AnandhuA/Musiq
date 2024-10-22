import 'result.dart';

class Songs {
  List<Result>? results;
  int? position;

  Songs({this.results, this.position});

  factory Songs.fromJson(Map<String, dynamic> json) => Songs(
        results: (json['results'] as List<dynamic>?)
            ?.map((e) => Result.fromJson(e as Map<String, dynamic>))
            .toList(),
        position: json['position'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'results': results?.map((e) => e.toJson()).toList(),
        'position': position,
      };
}
