import 'data.dart';

class PlayListModel {
  bool? success;
  Data? data;

  PlayListModel({this.success, this.data});

  factory PlayListModel.fromJson(Map<String, dynamic> json) => PlayListModel(
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
