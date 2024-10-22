import 'data.dart';

class SearchSongModel {
  bool? success;
  Data? data;

  SearchSongModel({this.success, this.data});

  factory SearchSongModel.fromJson(Map<String, dynamic> json) {
    return SearchSongModel(
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
