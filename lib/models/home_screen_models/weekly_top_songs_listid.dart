import 'english.dart';
import 'hindi.dart';

class WeeklyTopSongsListid {
  English? english;
  Hindi? hindi;

  WeeklyTopSongsListid({this.english, this.hindi});

  factory WeeklyTopSongsListid.fromJson(Map<String, dynamic> json) {
    return WeeklyTopSongsListid(
      english: json['english'] == null
          ? null
          : English.fromJson(json['english'] as Map<String, dynamic>),
      hindi: json['hindi'] == null
          ? null
          : Hindi.fromJson(json['hindi'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() => {
        'english': english?.toJson(),
        'hindi': hindi?.toJson(),
      };
}
