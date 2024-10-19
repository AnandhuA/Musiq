import 'package:musiq/models/song_model/image.dart';

import 'artist_map.dart';

class Datum {
  ArtistMap? artistMap;
  String? copyrightText;
  bool? explicit;
  String? headerDesc;
  String? id;
  List<Image>? image;
  bool? isDolbyContent;
  String? labelUrl;
  String? language;
  int? listCount;
  String? listType;
  String? name;
  int? playCount;
  List<dynamic>? songs;
  String? subtitle;
  String? type;
  String? url;
  int? year;
  int? songCount;

  Datum({
    this.artistMap,
    this.copyrightText,
    this.explicit,
    this.headerDesc,
    this.id,
    this.image,
    this.isDolbyContent,
    this.labelUrl,
    this.language,
    this.listCount,
    this.listType,
    this.name,
    this.playCount,
    this.songs,
    this.subtitle,
    this.type,
    this.url,
    this.year,
    this.songCount,
  });

  factory Datum.fromJson(Map<String, dynamic> json) {
    var imageData = json['image'];

    // Check the type of 'image' and handle accordingly
    List<Image> imageList;
    if (imageData is String) {
      // If it's a string, treat it as a single image and convert it to a list
      imageList = [
        Image.fromJson({"link": imageData})
      ];
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

    return Datum(
      artistMap: json['artistMap'] == null
          ? null
          : ArtistMap.fromJson(json['artistMap'] as Map<String, dynamic>),
      copyrightText: json['copyright_text'] as String?,
      explicit: json['explicit'] as bool?,
      headerDesc: json['header_desc'] as String?,
      id: json['id'] as String?,
      image: imageList,
      isDolbyContent: json['is_dolby_content'] as bool?,
      labelUrl: json['label_url'] as String?,
      language: json['language'] as String?,
      listCount: json['list_count'] as int?,
      listType: json['list_type'] as String?,
      name: json['name'] as String?,
      playCount: json['play_count'] as int?,
      songs: json['songs'] as List<dynamic>?,
      subtitle: json['subtitle'] as String?,
      type: json['type'] as String?,
      url: json['url'] as String?,
      year: json['year'] as int?,
      songCount: json['song_count'] as int?,
    );
  }

  Map<String, dynamic> toJson() => {
        'artistMap': artistMap?.toJson(),
        'copyright_text': copyrightText,
        'explicit': explicit,
        'header_desc': headerDesc,
        'id': id,
        'image': image?.map((e) => e.toJson()).toList(),
        'is_dolby_content': isDolbyContent,
        'label_url': labelUrl,
        'language': language,
        'list_count': listCount,
        'list_type': listType,
        'name': name,
        'play_count': playCount,
        'songs': songs,
        'subtitle': subtitle,
        'type': type,
        'url': url,
        'year': year,
        'song_count': songCount,
      };
}
