class Tags {
  List<String>? mood;

  Tags({this.mood});

  factory Tags.fromJson(Map<String, dynamic> json) => Tags(
        mood: json['mood'] as List<String>?,
      );

  Map<String, dynamic> toJson() => {
        'mood': mood,
      };
}
