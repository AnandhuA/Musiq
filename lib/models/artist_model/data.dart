import 'package:musiq/models/song_model/image.dart';
import 'package:musiq/models/song_model/song.dart';


import 'similar_artist.dart';
import 'top_album.dart';

class Data {
  String? id;
  String? name;
  String? url;
  String? type;
  int? followerCount;
  String? fanCount;
  dynamic isVerified;
  String? dominantLanguage;
  String? dominantType;
  List<dynamic>? bio;
  String? dob;
  dynamic fb;
  dynamic twitter;
  String? wiki;
  List<dynamic>? availableLanguages;
  bool? isRadioPresent;
  List<Image>? image;
  List<Song>? topSongs;
  List<TopAlbum>? topAlbums;
  List<Song>? singles;
  List<SimilarArtist>? similarArtists;

  Data({
    this.id,
    this.name,
    this.url,
    this.type,
    this.followerCount,
    this.fanCount,
    this.isVerified,
    this.dominantLanguage,
    this.dominantType,
    this.bio,
    this.dob,
    this.fb,
    this.twitter,
    this.wiki,
    this.availableLanguages,
    this.isRadioPresent,
    this.image,
    this.topSongs,
    this.topAlbums,
    this.singles,
    this.similarArtists,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json['id'] as String?,
        name: json['name'] as String?,
        url: json['url'] as String?,
        type: json['type'] as String?,
        followerCount: json['followerCount'] as int?,
        fanCount: json['fanCount'] as String?,
        isVerified: json['isVerified'] as dynamic,
        dominantLanguage: json['dominantLanguage'] as String?,
        dominantType: json['dominantType'] as String?,
        bio: json['bio'] as List<dynamic>?,
        dob: json['dob'] as String?,
        fb: json['fb'] as dynamic,
        twitter: json['twitter'] as dynamic,
        wiki: json['wiki'] as String?,
        availableLanguages: json['availableLanguages'] as List<dynamic>?,
        isRadioPresent: json['isRadioPresent'] as bool?,
        image: (json['image'] as List<dynamic>?)
            ?.map((e) => Image.fromJson(e as Map<String, dynamic>))
            .toList(),
        topSongs: (json['topSongs'] as List<dynamic>?)
            ?.map((e) => Song.fromJson(e as Map<String, dynamic>))
            .toList(),
        topAlbums: (json['topAlbums'] as List<dynamic>?)
            ?.map((e) => TopAlbum.fromJson(e as Map<String, dynamic>))
            .toList(),
        singles: (json['singles'] as List<dynamic>?)
            ?.map((e) => Song.fromJson(e as Map<String, dynamic>))
            .toList(),
        similarArtists: (json['similarArtists'] as List<dynamic>?)
            ?.map((e) => SimilarArtist.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'url': url,
        'type': type,
        'followerCount': followerCount,
        'fanCount': fanCount,
        'isVerified': isVerified,
        'dominantLanguage': dominantLanguage,
        'dominantType': dominantType,
        'bio': bio,
        'dob': dob,
        'fb': fb,
        'twitter': twitter,
        'wiki': wiki,
        'availableLanguages': availableLanguages,
        'isRadioPresent': isRadioPresent,
        'image': image?.map((e) => e.toJson()).toList(),
        'topSongs': topSongs?.map((e) => e.toJson()).toList(),
        'topAlbums': topAlbums?.map((e) => e.toJson()).toList(),
        'singles': singles?.map((e) => e.toJson()).toList(),
        'similarArtists': similarArtists?.map((e) => e.toJson()).toList(),
      };
}
