import 'datum.dart';

class Promo12 {
  List<Datum>? data;
  int? position;
  String? source;
  String? subtitle;
  String? title;

  Promo12({
    this.data,
    this.position,
    this.source,
    this.subtitle,
    this.title,
  });

  factory Promo12.fromJson(Map<String, dynamic> json) => Promo12(
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
