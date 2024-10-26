import 'package:hive/hive.dart';

part 'image.g.dart'; // Required for Hive code generation

@HiveType(typeId: 1) // Assign a unique typeId for the Image class
class Image {
  @HiveField(0)
  String imageUrl;

  @HiveField(1)
  String? quality;

  Image({required this.imageUrl, this.quality});

  factory Image.fromJson(dynamic json) {
    if (json is String) {
      return Image(imageUrl: json);
    } else if (json is Map) {
      return Image(
        imageUrl: json['url'] ?? json['link'],
        quality: json['quality'],
      );
    } else {
      throw ArgumentError('Invalid image format: $json');
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'url': imageUrl,
      'quality': quality,
    };
  }
}
