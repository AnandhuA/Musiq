import 'artist.dart';
import '../song_model/image.dart';
import '../song_model/song.dart';

class Data {
  String? id;
  String? name;
  String? description;
  String? type;
  dynamic year;
  dynamic playCount;
  String? language;
  bool? explicitContent;
  String? url;
  int? songCount;
  List<Artist>? artists;
  List<Image>? image;
  List<Song>? songs;

  Data({
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

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json['id'] as String?,
        name: json['name'] as String?,
        description: json['description'] as String?,
        type: json['type'] as String?,
        year: json['year'] as dynamic,
        playCount: json['playCount'] as dynamic,
        language: json['language'] as String?,
        explicitContent: json['explicitContent'] as bool?,
        url: json['url'] as String?,
        songCount: json['songCount'] as int?,
        artists: (json['artists'] as List<dynamic>?)
            ?.map((e) => Artist.fromJson(e as Map<String, dynamic>))
            .toList(),
        image: (json['image'] as List<dynamic>?)
            ?.map((e) => Image.fromJson(e as Map<String, dynamic>))
            .toList(),
        songs: (json['songs'] as List<dynamic>?)
            ?.map((e) => Song.fromJson(e as Map<String, dynamic>))
            .toList(),
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
        'artists': artists?.map((e) => e.toJson()).toList(),
        'image': image?.map((e) => e.toJson()).toList(),
        'songs': songs?.map((e) => e.toJson()).toList(),
      };
}
