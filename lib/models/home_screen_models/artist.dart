import 'package:musiq/models/song_model/image.dart';

class Artist {
  String? id;
  List<Image>? image;
  String? name;
  String? role;
  String? type;
  String? url;

  Artist({this.id, this.image, this.name, this.role, this.type, this.url});

  factory Artist.fromJson(Map<String, dynamic> json) {
    var imageData = json['image'];

    // Check if 'image' is a List or String and handle accordingly
    List<Image> imageList;
    if (imageData is String) {
      // If it's a string, treat it as a single image and convert to list
      imageList = [Image.fromJson(imageData)];
    } else if (imageData is List) {
      // If it's already a list, map each element to an Image
      imageList = imageData
          .map((e) => Image.fromJson(e as Map<String, dynamic>))
          .toList();
    } else if (imageData is Map) {
      // If it's a single image object (like a Map), convert it to a list
      imageList = [Image.fromJson(imageData)];
    } else {
      imageList = []; // If no valid image is found, return an empty list
    }

    return Artist(
      id: json['id'] as String?,
      image: imageList,
      name: json['name'] as String?,
      role: json['role'] as String?,
      type: json['type'] as String?,
      url: json['url'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'image': image?.map((e) => e.toJson()).toList(),
        'name': name,
        'role': role,
        'type': type,
        'url': url,
      };
}
