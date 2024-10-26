import 'package:hive/hive.dart';

part 'album.g.dart'; // Required for Hive code generation

@HiveType(typeId: 4) // Assign a unique typeId for the Album class
class Album {
  @HiveField(0)
  String? id;

  @HiveField(1)
  String name;

  @HiveField(2)
  String? url;

  Album({
    this.id,
    required this.name,
    this.url,
  });

  factory Album.fromJson(Map<String, dynamic> json) => Album(
        id: json['id'] as String?,
        name: json['name'] ?? "null",
        url: json['url'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'url': url,
      };
}
