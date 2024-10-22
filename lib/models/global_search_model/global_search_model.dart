import 'data.dart';

class GlobalSearchModel {
  bool? success;
  Data? data;

  GlobalSearchModel({this.success, this.data});

  factory GlobalSearchModel.fromJson(Map<String, dynamic> json) {
    return GlobalSearchModel(
      success: json['success'] as bool?,
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() => {
        'success': success,
        'data': data?.toJson(),
      };
}
