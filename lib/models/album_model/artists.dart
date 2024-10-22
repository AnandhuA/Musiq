class Artists {
  int? position;
  String? source;
  String? subtitle;
  String? title;

  Artists({this.position, this.source, this.subtitle, this.title});

  factory Artists.fromJson(Map<String, dynamic> json) => Artists(
        position: json['position'] as int?,
        source: json['source'] as String?,
        subtitle: json['subtitle'] as String?,
        title: json['title'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'position': position,
        'source': source,
        'subtitle': subtitle,
        'title': title,
      };
}
