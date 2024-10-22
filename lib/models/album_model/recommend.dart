import 'params.dart';

class Recommend {
  Params? params;
  int? position;
  String? source;
  String? subtitle;
  String? title;

  Recommend({
    this.params,
    this.position,
    this.source,
    this.subtitle,
    this.title,
  });

  factory Recommend.fromJson(Map<String, dynamic> json) => Recommend(
        params: json['params'] == null
            ? null
            : Params.fromJson(json['params'] as Map<String, dynamic>),
        position: json['position'] as int?,
        source: json['source'] as String?,
        subtitle: json['subtitle'] as String?,
        title: json['title'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'params': params?.toJson(),
        'position': position,
        'source': source,
        'subtitle': subtitle,
        'title': title,
      };
}
