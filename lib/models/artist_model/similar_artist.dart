
import 'package:musiq/models/song_model/image.dart';

import 'languages.dart';

class SimilarArtist {
  String? id;
  String? name;
  String? url;
  List<Image>? image;
  Languages? languages;
  String? wiki;
  String? dob;
  String? fb;
  String? twitter;
  bool? isRadioPresent;
  String? type;
  String? dominantType;
  String? aka;
  dynamic bio;
  List<SimilarArtist>? similarArtists;

  SimilarArtist({
    this.id,
    this.name,
    this.url,
    this.image,
    this.languages,
    this.wiki,
    this.dob,
    this.fb,
    this.twitter,
    this.isRadioPresent,
    this.type,
    this.dominantType,
    this.aka,
    this.bio,
    this.similarArtists,
  });

  factory SimilarArtist.fromJson(Map<String, dynamic> json) => SimilarArtist(
        id: json['id'] as String?,
        name: json['name'] as String?,
        url: json['url'] as String?,
        image: (json['image'] as List<dynamic>?)
            ?.map((e) => Image.fromJson(e as Map<String, dynamic>))
            .toList(),
        languages: json['languages'] == null
            ? null
            : Languages.fromJson(json['languages'] as Map<String, dynamic>),
        wiki: json['wiki'] as String?,
        dob: json['dob'] as String?,
        fb: json['fb'] as String?,
        twitter: json['twitter'] as String?,
        isRadioPresent: json['isRadioPresent'] as bool?,
        type: json['type'] as String?,
        dominantType: json['dominantType'] as String?,
        aka: json['aka'] as String?,
        bio: json['bio'] as dynamic,
        similarArtists: (json['similarArtists'] as List<dynamic>?)
            ?.map((e) => SimilarArtist.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'url': url,
        'image': image?.map((e) => e.toJson()).toList(),
        'languages': languages?.toJson(),
        'wiki': wiki,
        'dob': dob,
        'fb': fb,
        'twitter': twitter,
        'isRadioPresent': isRadioPresent,
        'type': type,
        'dominantType': dominantType,
        'aka': aka,
        'bio': bio,
        'similarArtists': similarArtists?.map((e) => e.toJson()).toList(),
      };
}
