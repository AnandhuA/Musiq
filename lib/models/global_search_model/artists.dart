import 'result.dart';

class Artists {
  List<Result>? results;
  int? position;

  Artists({this.results, this.position});

  factory Artists.fromJson(Map<String, dynamic> json) => Artists(
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
