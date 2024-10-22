import 'data.dart';

class SearchAlbumModel {
  bool? success;
  Data? data;

  SearchAlbumModel({this.success, this.data});

  factory SearchAlbumModel.fromJson(Map<String, dynamic> json) {
    return SearchAlbumModel(
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
