import 'package:hive/hive.dart';
import 'image.dart';

part 'all.g.dart'; // This will be generated

@HiveType(typeId: 6) // Ensure the type ID is unique
class All {
  @HiveField(0)
  String? id;

  @HiveField(1)
  String? name;

  @HiveField(2)
  String? role;

  @HiveField(3)
  List<Image>? image; // Ensure the Image adapter is registered

  @HiveField(4)
  String? type;

  @HiveField(5)
  String? url;

  All({this.id, this.name, this.role, this.image, this.type, this.url});

  factory All.fromJson(Map<String, dynamic> json) => All(
        id: json['id'] as String?,
        name: json['name'] as String?,
        role: json['role'] as String?,
        image: _parseImageList(json['image']),
        type: json['type'] as String?,
        url: json['url'] as String?,
      );

  static List<Image>? _parseImageList(dynamic imageJson) {
    if (imageJson is List) {
      return imageJson
          .map((e) => Image.fromJson(e as Map<String, dynamic>))
          .toList();
    } else if (imageJson is String) {
      return [Image(imageUrl: imageJson)];
    }
    return null;
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'role': role,
        'image': image?.map((e) => e.toJson()).toList(),
        'type': type,
        'url': url,
      };
}
