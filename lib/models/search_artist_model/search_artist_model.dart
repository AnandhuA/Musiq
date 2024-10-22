import 'data.dart';

class SearchArtistModel {
  bool? success;
  Data? data;

  SearchArtistModel({this.success, this.data});

  factory SearchArtistModel.fromJson(Map<String, dynamic> json) {
    return SearchArtistModel(
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
