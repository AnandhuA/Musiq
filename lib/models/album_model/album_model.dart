import 'data.dart';

class AlbumModel {
  Data? data;
  String? message;
  String? status;

  AlbumModel({this.data, this.message, this.status});

  factory AlbumModel.fromJson(Map<String, dynamic> json) => AlbumModel(
        data: json['data'] == null
            ? null
            : Data.fromJson(json['data'] as Map<String, dynamic>),
        message: json['message'] as String?,
        status: json['status'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'data': data?.toJson(),
        'message': message,
        'status': status,
      };
}
