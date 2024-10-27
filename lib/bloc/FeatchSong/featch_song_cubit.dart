import 'dart:convert';
import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:http/http.dart';
import 'package:meta/meta.dart';
import 'package:musiq/data/savan_2.0.dart';
import 'package:musiq/models/album_model/album_model.dart';
import 'package:musiq/models/artist_model/artist_model.dart';
import 'package:musiq/models/play_list_model/play_list_model.dart';
import 'package:musiq/models/song_model/song.dart';

part 'featch_song_state.dart';

class FeatchSongCubit extends Cubit<FeatchSongState> {
  FeatchSongCubit() : super(FeatchSongInitial());
//------- check funtion by type -----------
  void fetchData(
      {required String type, required String id, required String imageUrl}) {
    log("$type");
    switch (type) {
      case 'album':
        fetchAlbum(id: id, imageUrl: imageUrl);
        break;
      case 'playlist':
        fetchPlayList(id: id, imageUrl: imageUrl);
        break;
      case 'song':
        fetchSongById(id: id);
      case 'artist':
        featchArtistSongs(id: id, imageUrl: imageUrl);
      default:
        print('Unknown type: $type');
        break;
    }
  }

//-------- featch album by id --------------
  void fetchAlbum({required String id, required String imageUrl}) async {
    emit(FeatchSongLoading());
    final Response? responce = await Saavan2.featchAlbum(albumId: id);
    if (responce != null && responce.statusCode == 200) {
      final data = jsonDecode(responce.body);
      AlbumModel model = AlbumModel.fromJson(data);
      emit(FeatchAlbumAndPlayListLoaded(
          albumModel: model, playListModel: null, imageUrl: imageUrl));
    } else {
      log("error--${responce?.statusCode}");
    }
  }

//----------featch playlist by id ---------------
  void fetchPlayList({required String id, required String imageUrl}) async {
    emit(FeatchSongLoading());
    final Response? responce = await Saavan2.featchPlayList(playlistId: id);
    if (responce != null && responce.statusCode == 200) {
      final data = jsonDecode(responce.body);
      PlayListModel model = PlayListModel.fromJson(data);
      log("${model.data?.songs?.length}");
      emit(FeatchAlbumAndPlayListLoaded(
          albumModel: null, playListModel: model, imageUrl: imageUrl));
    } else {
      log("error--${responce?.statusCode}");
    }
  }

//---------- featch Artis by id ------------
  void featchArtistSongs({required String id, required String imageUrl}) async {
    emit(FeatchSongLoading());
    log("set");
    final Response? responce = await Saavan2.featchArtist(artistId: id);
    log("----------${responce?.statusCode}");
    if (responce != null && responce.statusCode == 200) {
      final data = jsonDecode(responce.body);
      ArtistModel model = ArtistModel.fromJson(data);
      emit(FeatchArtistLoadedState(model: model));
    } else {
      log("error--${responce?.statusCode}");
    }
  }

//---------- featch song by id ------------
  void fetchSongById({required String id}) async {
    log("----song");
    emit(FeatchSongLoading());
    final Response? responce = await Saavan2.featchSong(songId: id);
    if (responce != null && responce.statusCode == 200) {
      final data = jsonDecode(responce.body);
      if (data["data"] is List) {
        List<Song> songs = (data["data"] as List)
            .map((songJson) => Song.fromJson(songJson as Map<String, dynamic>))
            .toList();
        emit(FeatchSongByIDLoaded(songs: songs));
      } else {
        final Song model = Song.fromJson(data["data"]);
        emit(FeatchSongByIDLoaded(songs: [model]));
      }
    } else {
      log("error--${responce?.statusCode}");
    }
  }
}
