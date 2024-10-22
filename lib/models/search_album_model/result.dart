import 'package:musiq/models/song_model/image.dart';

import 'artists.dart';

class Result {
  String? id;
  String? name;
  String? description;
  String? url;
  int? year;
  String? type;
  dynamic playCount;
  String? language;
  bool? explicitContent;
  Artists? artists;
  List<Image>? image;

  Result({
    this.id,
    this.name,
    this.description,
    this.url,
    this.year,
    this.type,
    this.playCount,
    this.language,
    this.explicitContent,
    this.artists,
    this.image,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json['id'] as String?,
        name: json['name'] as String?,
        description: json['description'] as String?,
        url: json['url'] as String?,
        year: json['year'] as int?,
        type: json['type'] as String?,
        playCount: json['playCount'] as dynamic,
        language: json['language'] as String?,
        explicitContent: json['explicitContent'] as bool?,
        artists: json['artists'] == null
            ? null
            : Artists.fromJson(json['artists'] as Map<String, dynamic>),
        image: (json['image'] as List<dynamic>?)
            ?.map((e) => Image.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'description': description,
        'url': url,
        'year': year,
        'type': type,
        'playCount': playCount,
        'language': language,
        'explicitContent': explicitContent,
        'artists': artists?.toJson(),
        'image': image?.map((e) => e.toJson()).toList(),
      };
}
