import 'result.dart';

class TopQuery {
  List<Result>? results;
  int? position;

  TopQuery({this.results, this.position});

  factory TopQuery.fromJson(Map<String, dynamic> json) => TopQuery(
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
