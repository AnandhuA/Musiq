class Image {
  String? quality;
  String? url;

  Image({this.quality, this.url});

  factory Image.fromJson(Map<String, dynamic> json) => Image(
        quality: json['quality'] as String?,
        url: json['url'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'quality': quality,
        'url': url,
      };
}
