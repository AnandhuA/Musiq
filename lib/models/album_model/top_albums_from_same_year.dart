import 'params.dart';

class TopAlbumsFromSameYear {
  Params? params;
  int? position;
  String? source;
  String? subtitle;
  String? title;

  TopAlbumsFromSameYear({
    this.params,
    this.position,
    this.source,
    this.subtitle,
    this.title,
  });

  factory TopAlbumsFromSameYear.fromJson(Map<String, dynamic> json) {
    return TopAlbumsFromSameYear(
      params: json['params'] == null
          ? null
          : Params.fromJson(json['params'] as Map<String, dynamic>),
      position: json['position'] as int?,
      source: json['source'] as String?,
      subtitle: json['subtitle'] as String?,
      title: json['title'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'params': params?.toJson(),
        'position': position,
        'source': source,
        'subtitle': subtitle,
        'title': title,
      };
}
