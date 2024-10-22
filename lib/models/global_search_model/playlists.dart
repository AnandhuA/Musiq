class Playlists {
  List<dynamic>? results;
  int? position;

  Playlists({this.results, this.position});

  factory Playlists.fromJson(Map<String, dynamic> json) => Playlists(
        results: json['results'] as List<dynamic>?,
        position: json['position'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'results': results,
        'position': position,
      };
}
