import 'package:musiq/models/song_model/image.dart';

class PrimaryArtist {
  String? id;
  List<Image>? image;
  String? name;
  String? role;
  String? type;
  String? url;

  PrimaryArtist({
    this.id,
    this.image,
    this.name,
    this.role,
    this.type,
    this.url,
  });

  factory PrimaryArtist.fromJson(Map<String, dynamic> json) {
    var imageData = json['image'];

    // Check the type of 'image' and handle accordingly
    List<Image> imageList;
    if (imageData is String) {
      // If it's a string, treat it as a single image and convert it to a list
      imageList = [Image.fromJson(imageData)];
    } else if (imageData is List) {
      // If it's a list, map each item to an Image object
      imageList = imageData
          .map((e) => Image.fromJson(e as Map<String, dynamic>))
          .toList();
    } else if (imageData is Map) {
      // If it's a map (single image object), treat it as a single image and convert to a list
      imageList = [Image.fromJson(imageData)];
    } else {
      imageList = []; // If no valid image found, return an empty list
    }

    return PrimaryArtist(
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
