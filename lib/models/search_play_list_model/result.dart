import 'package:musiq/models/song_model/image.dart';


class Result {
  String? id;
  String? name;
  String? type;
  List<Image>? image;
  String? url;
  int? songCount;
  String? language;
  bool? explicitContent;

  Result({
    this.id,
    this.name,
    this.type,
    this.image,
    this.url,
    this.songCount,
    this.language,
    this.explicitContent,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json['id'] as String?,
        name: json['name'] as String?,
        type: json['type'] as String?,
        image: (json['image'] as List<dynamic>?)
            ?.map((e) => Image.fromJson(e as Map<String, dynamic>))
            .toList(),
        url: json['url'] as String?,
        songCount: json['songCount'] as int?,
        language: json['language'] as String?,
        explicitContent: json['explicitContent'] as bool?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'type': type,
        'image': image?.map((e) => e.toJson()).toList(),
        'url': url,
        'songCount': songCount,
        'language': language,
        'explicitContent': explicitContent,
      };
}
