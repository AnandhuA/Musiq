class LibraryModel {
  String id;
  String imageUrl;
  String title;
  String type;

  LibraryModel({
    required this.id,
    required this.imageUrl,
    required this.title,
    required this.type,
  });

  factory LibraryModel.fromJson(Map<String, dynamic> json) {
    return LibraryModel(
      id: json['id'] as String,
      imageUrl: json['imageUrl'] as String,
      title: json['title'] as String,
      type: json['type'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'imageUrl': imageUrl,
      'title': title,
      'type': type,
    };
  }
}

