class Image {
  String? imageUrl;
  String? quality;

  Image({this.imageUrl, this.quality});

  factory Image.fromJson(dynamic json) {
    if (json is String) {
      // If the image is a string, treat it as a single image URL.
      return Image(imageUrl: json);
    } else if (json is Map) {
      // Check if the key is 'url' or 'link' for the image URL.
      return Image(
        imageUrl: json['url'] ?? json['link'], // Handle both 'url' and 'link'.
        quality: json['quality'],
      );
    } else {
      throw ArgumentError('Invalid image format: $json');
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'imageUrl': imageUrl, // Normalizing to 'imageUrl' when serializing.
      'quality': quality,
    };
  }
}
