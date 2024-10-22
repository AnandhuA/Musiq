import 'songdata.dart';

class NewHomeScreenModel {
  Songdata? songdata;
  String? message;
  String? status;

  NewHomeScreenModel({this.songdata, this.message, this.status});

  factory NewHomeScreenModel.fromJson(Map<String, dynamic> json) =>
      NewHomeScreenModel(
        songdata: json['data'] == null
            ? null
            : Songdata.fromJson(json['data'] as Map<String, dynamic>),
        message: json['message'] as String?,
        status: json['status'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'data': songdata?.toJson(),
        'message': message,
        'status': status,
      };
}
