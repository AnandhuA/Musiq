import 'package:musiq/models/song_model/artists.dart';
import 'package:musiq/models/song_model/image.dart';




class TopAlbum {
  String? id;
  String? name;
  String? description;
  String? type;
  int? year;
  dynamic playCount;
  String? language;
  bool? explicitContent;
  String? url;
  int? songCount;
  Artists? artists;
  List<Image>? image;
  dynamic songs;

  TopAlbum({
    this.id,
    this.name,
    this.description,
    this.type,
    this.year,
    this.playCount,
    this.language,
    this.explicitContent,
    this.url,
    this.songCount,
    this.artists,
    this.image,
    this.songs,
  });

  factory TopAlbum.fromJson(Map<String, dynamic> json) => TopAlbum(
        id: json['id'] as String?,
        name: json['name'] as String?,
        description: json['description'] as String?,
        type: json['type'] as String?,
        year: json['year'] as int?,
        playCount: json['playCount'] as dynamic,
        language: json['language'] as String?,
        explicitContent: json['explicitContent'] as bool?,
        url: json['url'] as String?,
        songCount: json['songCount'] as int?,
        artists: json['artists'] == null
            ? null
            : Artists.fromJson(json['artists'] as Map<String, dynamic>),
        image: (json['image'] as List<dynamic>?)
            ?.map((e) => Image.fromJson(e as Map<String, dynamic>))
            .toList(),
        songs: json['songs'] as dynamic,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'description': description,
        'type': type,
        'year': year,
        'playCount': playCount,
        'language': language,
        'explicitContent': explicitContent,
        'url': url,
        'songCount': songCount,
        'artists': artists?.toJson(),
        'image': image?.map((e) => e.toJson()).toList(),
        'songs': songs,
      };
}
