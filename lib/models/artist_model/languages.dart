class Languages {
  String? telugu;
  String? unknown;
  String? punjabi;
  String? english;
  String? kannada;
  String? instrumental;
  String? tulu;
  String? hindi;
  String? sinhalese;
  String? malayalam;
  String? sanskrit;
  String? tamil;

  Languages({
    this.telugu,
    this.unknown,
    this.punjabi,
    this.english,
    this.kannada,
    this.instrumental,
    this.tulu,
    this.hindi,
    this.sinhalese,
    this.malayalam,
    this.sanskrit,
    this.tamil,
  });

  factory Languages.fromJson(Map<String, dynamic> json) => Languages(
        telugu: json['telugu'] as String?,
        unknown: json['unknown'] as String?,
        punjabi: json['punjabi'] as String?,
        english: json['english'] as String?,
        kannada: json['kannada'] as String?,
        instrumental: json['instrumental'] as String?,
        tulu: json['tulu'] as String?,
        hindi: json['hindi'] as String?,
        sinhalese: json['sinhalese'] as String?,
        malayalam: json['malayalam'] as String?,
        sanskrit: json['sanskrit'] as String?,
        tamil: json['tamil'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'telugu': telugu,
        'unknown': unknown,
        'punjabi': punjabi,
        'english': english,
        'kannada': kannada,
        'instrumental': instrumental,
        'tulu': tulu,
        'hindi': hindi,
        'sinhalese': sinhalese,
        'malayalam': malayalam,
        'sanskrit': sanskrit,
        'tamil': tamil,
      };
}
