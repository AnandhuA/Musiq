class Hindi {
  int? count;
  String? image;
  String? listid;
  dynamic title;

  Hindi({this.count, this.image, this.listid, this.title});

  factory Hindi.fromJson(Map<String, dynamic> json) => Hindi(
        count: json['count'] as int?,
        image: json['image'] as String?,
        listid: json['listid'] as String?,
        title: json['title'] as dynamic,
      );

  Map<String, dynamic> toJson() => {
        'count': count,
        'image': image,
        'listid': listid,
        'title': title,
      };
}
