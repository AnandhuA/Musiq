import 'package:musiq/models/song_model/song.dart';

class Data {
  int? total;
  int? start;
  List<Song>? results;

  Data({this.total, this.start, this.results});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        total: json['total'] as int?,
        start: json['start'] as int?,
        results: (json['results'] as List<dynamic>?)
            ?.map((e) => Song.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'total': total,
        'start': start,
        'results': results?.map((e) => e.toJson()).toList(),
      };
}
