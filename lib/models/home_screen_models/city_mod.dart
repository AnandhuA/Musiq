import 'datum.dart';

class CityMod {
  List<Datum>? data;
  int? position;
  String? source;
  String? subtitle;
  String? title;

  CityMod({
    this.data,
    this.position,
    this.source,
    this.subtitle,
    this.title,
  });

  factory CityMod.fromJson(Map<String, dynamic> json) => CityMod(
        data: (json['data'] as List<dynamic>?)
            ?.map((e) => Datum.fromJson(e as Map<String, dynamic>))
            .toList(),
        position: json['position'] as int?,
        source: json['source'] as String?,
        subtitle: json['subtitle'] as String?,
        title: json['title'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'data': data?.map((e) => e.toJson()).toList(),
        'position': position,
        'source': source,
        'subtitle': subtitle,
        'title': title,
      };
}
