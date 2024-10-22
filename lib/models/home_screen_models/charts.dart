import 'datum.dart';

class Charts {
  List<Datum>? data;
  String? featuredText;
  int? position;
  String? source;
  String? subtitle;
  String? title;

  Charts({
    this.data,
    this.featuredText,
    this.position,
    this.source,
    this.subtitle,
    this.title,
  });

  factory Charts.fromJson(Map<String, dynamic> json) => Charts(
        data: (json['data'] as List<dynamic>?)
            ?.map((e) => Datum.fromJson(e as Map<String, dynamic>))
            .toList(),
        featuredText: json['featured_text'] as String?,
        position: json['position'] as int?,
        source: json['source'] as String?,
        subtitle: json['subtitle'] as String?,
        title: json['title'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'data': data?.map((e) => e.toJson()).toList(),
        'featured_text': featuredText,
        'position': position,
        'source': source,
        'subtitle': subtitle,
        'title': title,
      };
}
