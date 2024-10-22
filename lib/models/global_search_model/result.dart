import 'image.dart';

class Result {
  String? id;
  String? title;
  List<Image>? image;
  String? url;
  String? type;
  String? language;
  String? description;

  Result({
    this.id,
    this.title,
    this.image,
    this.url,
    this.type,
    this.language,
    this.description,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json['id'] as String?,
        title: json['title'] as String?,
        image: (json['image'] as List<dynamic>?)
            ?.map((e) => Image.fromJson(e as Map<String, dynamic>))
            .toList(),
        url: json['url'] as String?,
        type: json['type'] as String?,
        language: json['language'] as String?,
        description: json['description'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'image': image?.map((e) => e.toJson()).toList(),
        'url': url,
        'type': type,
        'language': language,
        'description': description,
      };
}
