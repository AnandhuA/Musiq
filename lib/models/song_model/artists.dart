import 'package:hive/hive.dart';
import 'all.dart';
import 'primary.dart';

part 'artists.g.dart'; // Required for Hive code generation

@HiveType(typeId: 3) // Assign a unique typeId for the Artists class
class Artists {
  @HiveField(0)
  List<Primary>? primary;

  @HiveField(1)
  List<dynamic>? featured;

  @HiveField(2)
  List<All>? all;

  Artists({this.primary, this.featured, this.all});

  factory Artists.fromJson(Map<String, dynamic> json) => Artists(
        primary: (json['primary'] as List<dynamic>?)
            ?.map((e) => Primary.fromJson(e as Map<String, dynamic>))
            .toList(),
        featured: json['featured'] as List<dynamic>?,
        all: (json['all'] as List<dynamic>?)
                ?.map((e) => All.fromJson(e as Map<String, dynamic>))
                .toList() ??
            (json['artists'] as List<dynamic>?)
                ?.map((e) => All.fromJson(e as Map<String, dynamic>))
                .toList(),
      );

  Map<String, dynamic> toJson() => {
        'primary': primary?.map((e) => e.toJson()).toList(),
        'featured': featured,
        'all': all?.map((e) => e.toJson()).toList(),
      };
}
