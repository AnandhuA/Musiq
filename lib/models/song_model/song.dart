
import 'album.dart';
import 'artists.dart';
import 'download_url.dart';
import 'image.dart';

class Song {
  String? id;
  String? name;
  String? type;
  String? year;
  String? releaseDate;
  int? duration;
  String? label;
  bool? explicitContent;
  int? playCount;
  String? language;
  bool? hasLyrics;
  dynamic lyricsId;
  String? url;
  String? copyright;
  Album? album;
  Artists? artists;
  List<Image>? image;
  List<DownloadUrl>? downloadUrl;
    DateTime? addedAt;

  Song({
    this.id,
    this.name,
    this.type,
    this.year,
    this.releaseDate,
    this.duration,
    this.label,
    this.explicitContent,
    this.playCount,
    this.language,
    this.hasLyrics,
    this.lyricsId,
    this.url,
    this.copyright,
    this.album,
    this.artists,
    this.image,
    this.downloadUrl,
    this.addedAt,
  });

  factory Song.fromJson(Map<String, dynamic> json) => Song(
        id: json['id'].toString() as String?,
        name: json['name'].toString() as String?,
        type: json['type'].toString() as String?,
        year: json['year'].toString() as String?,
        releaseDate: json['releaseDate'].toString() as String?,
        duration: json['duration'] as int?,
        label: json['label'].toString() as String?,
        explicitContent: json['explicitContent'] as bool?,
        playCount: json['playCount'] as int?,
        language: json['language'].toString() as String?,
        hasLyrics: json['hasLyrics'] as bool?,
        lyricsId: json['lyricsId'] as dynamic,
        url: json['url'].toString() as String?,
        copyright: json['copyright'].toString() as String?,
        album: (json['album'] is Map<String, dynamic>)
            ? Album.fromJson(json['album'] as Map<String, dynamic>)
            : null, 
        artists: (json['artists'] is Map<String, dynamic>)
            ? Artists.fromJson(json['artists'] as Map<String, dynamic>)
            : null,
        image: (json['image'] as List<dynamic>?)
            ?.map((e) => Image.fromJson(e as Map<String, dynamic>))
            .toList(),
        downloadUrl: (json['downloadUrl'] as List<dynamic>?)
            ?.map((e) => DownloadUrl.fromJson(e as Map<String, dynamic>))
            .toList(),
            addedAt: json['addedAt'] != null
            ? DateTime.parse(json['addedAt']) // Parse if exists
            : null,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'type': type,
        'year': year,
        'releaseDate': releaseDate,
        'duration': duration,
        'label': label,
        'explicitContent': explicitContent,
        'playCount': playCount,
        'language': language,
        'hasLyrics': hasLyrics,
        'lyricsId': lyricsId,
        'url': url,
        'copyright': copyright,
        'album': album?.toJson(),
        'artists': artists?.toJson(),
        'image': image?.map((e) => e.toJson()).toList(),
        'downloadUrl': downloadUrl?.map((e) => e.toJson()).toList(),
         'addedAt': addedAt?.toIso8601String(),
      };
}
