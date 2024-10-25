import 'image.dart';

class Primary {
  String? id;
  String? name;
  String? role;
  List<Image>? image;
  String? type;
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
