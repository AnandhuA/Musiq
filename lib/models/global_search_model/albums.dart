import 'result.dart';

class Albums {
  List<Result>? results;
  int? position;

  Albums({this.results, this.position});

  factory Albums.fromJson(Map<String, dynamic> json) => Albums(
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
