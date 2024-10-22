import '../play_list_model/all.dart';
import '../play_list_model/primary.dart';

class Artists {
  List<Primary>? primary;
  List<dynamic>? featured;
  List<All>? all;

  Artists({this.primary, this.featured, this.all});

  factory Artists.fromJson(Map<String, dynamic> json) => Artists(
        primary: (json['primary'] as List<dynamic>?)
            ?.map((e) => Primary.fromJson(e as Map<String, dynamic>))
            .toList(),
        featured: json['featured'] as List<dynamic>?,
        all: (json['all'] as List<dynamic>?)
            ?.map((e) => All.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'primary': primary?.map((e) => e.toJson()).toList(),
        'featured': featured,
        'all': all?.map((e) => e.toJson()).toList(),
      };
}
