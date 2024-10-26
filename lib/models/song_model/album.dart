class Album {
  String? id;
  String name;
  String? url;

  Album({
    this.id,
    required this.name,
    this.url,
  });

  factory Album.fromJson(Map<String, dynamic> json) => Album(
        id: json['id'] as String?,
        name: json['name'] ?? "null" ,
        url: json['url'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'url': url,
      };
}
