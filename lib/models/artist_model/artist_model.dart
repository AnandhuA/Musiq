import 'data.dart';

class ArtistModel {
  bool? success;
  Data? data;

  ArtistModel({this.success, this.data});

  factory ArtistModel.fromJson(Map<String, dynamic> json) => ArtistModel(
        success: json['success'] as bool?,
        data: json['data'] == null
            ? null
            : Data.fromJson(json['data'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'success': success,
        'data': data?.toJson(),
      };
}
