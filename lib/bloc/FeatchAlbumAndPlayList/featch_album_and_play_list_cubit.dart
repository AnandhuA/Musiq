import 'dart:convert';
import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:http/http.dart';
import 'package:meta/meta.dart';
import 'package:musiq/data/savan_2.0.dart';
import 'package:musiq/models/album_model/album_model.dart';
import 'package:musiq/models/play_list_model/play_list_model.dart';

part 'featch_album_and_play_list_state.dart';

class FeatchAlbumAndPlayListCubit extends Cubit<FeatchAlbumAndPlayListState> {
  FeatchAlbumAndPlayListCubit() : super(FeatchAlbumAndPlayListInitial());

  void fetchData(
      {required String type, required String id, required String imageUrl}) {
    switch (type) {
      case 'album':
        fetchAlbum(id: id, imageUrl: imageUrl);
        break;
      case 'playlist':
        fetchPlayList(id: id, imageUrl: imageUrl);
        break;
      case 'song':
        fetchSongById(id: id);
      default:
        print('Unknown type: $type');
        break;
    }
  }

  void fetchAlbum({
    required String id,
    required String imageUrl,
  }) async {
    emit(FeatchAlbumAndPlayListLoading());
    final Response? responce = await Saavan2.featchAlbum(albumId: id);
    if (responce != null && responce.statusCode == 200) {
      final data = jsonDecode(responce.body);
      AlbumModel model = AlbumModel.fromJson(data);
      log("${model}");
      emit(FeatchAlbumAndPlayListLoaded(
          albumModel: model, playListModel: null, imageUrl: imageUrl));
    }
  }

  void fetchPlayList({required String id, required String imageUrl}) async {
    emit(FeatchAlbumAndPlayListLoading());
    final Response? responce = await Saavan2.featchPlayList(playlistId: id);
    if (responce != null && responce.statusCode == 200) {
      final data = jsonDecode(responce.body);
      PlayListModel model = PlayListModel.fromJson(data);
      log("${model.data?.songs?.length}");
      emit(FeatchAlbumAndPlayListLoaded(
          albumModel: null, playListModel: model, imageUrl: imageUrl));
    }
  }

  void fetchSongById({required String id}) async {
    log("$id");
  }
}
