import 'package:hive/hive.dart';
import 'image.dart';

part 'primary.g.dart'; // This will be generated

@HiveType(typeId: 5) // Use a unique ID for the Primary class
class Primary {
  @HiveField(0)
  String? id;

  @HiveField(1)
  String? name;

  @HiveField(2)
  String? role;

  @HiveField(3)
  List<Image>? image; // Assuming you have an Image adapter registered.

  @HiveField(4)
  String? type;

  @HiveField(5)
  String? url;

  Primary({this.id, this.name, this.role, this.image, this.type, this.url});

  factory Primary.fromJson(Map<String, dynamic> json) => Primary(
        id: json['id'] as String?,
        name: json['name'] as String?,
        role: json['role'] as String?,
        image: (json['image'] as List<dynamic>?)
            ?.map((e) => Image.fromJson(e as Map<String, dynamic>))
            .toList(),
        type: json['type'] as String?,
        url: json['url'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'role': role,
        'image': image?.map((e) => e.toJson()).toList(),
        'type': type,
        'url': url,
      };
}
