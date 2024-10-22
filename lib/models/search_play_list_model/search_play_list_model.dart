import 'data.dart';

class SearchPlayListModel {
  bool? success;
  Data? data;

  SearchPlayListModel({this.success, this.data});

  factory SearchPlayListModel.fromJson(Map<String, dynamic> json) {
    return SearchPlayListModel(
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
