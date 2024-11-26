import 'dart:convert';
import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:http/http.dart';
import 'package:meta/meta.dart';
import 'package:musiq/core/helper_funtions.dart';
import 'package:musiq/data/savan_2.0.dart';
import 'package:musiq/models/album_model/album_model.dart';
import 'package:musiq/models/artist_model/artist_model.dart';
import 'package:musiq/models/play_list_model/play_list_model.dart';
import 'package:musiq/models/song_model/song.dart';

part 'fetch_song_state.dart';

class FetchSongCubit extends Cubit<FetchSongState> {
  FetchSongCubit() : super(FetchSongInitial());
//------- check funtion by type -----------
  void fetchData(
      {required String type, required String id, required String imageUrl}) {
    log("type::$type id::$id");
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
        FetchArtistSongs(id: id, imageUrl: imageUrl);
      case 'radio_station':
        FetchArtistSongs(id: id, imageUrl: imageUrl);
      case 'channel':
        FetchArtistSongs(id: id, imageUrl: imageUrl);
      case 'show':
        FetchArtistSongs(id: id, imageUrl: imageUrl);

      default:
        print('Unknown type: $type');
        break;
    }
  }

//-------- Fetch album by id --------------
  void fetchAlbum({required String id, required String imageUrl}) async {
    emit(FetchSongLoading());
    final Response? responce = await Saavan2.fetchAlbum(albumId: id);
    if (responce != null && responce.statusCode == 200) {
      final data = jsonDecode(responce.body);
      AlbumModel model = AlbumModel.fromJson(data);
      emit(FetchAlbumAndPlayListLoaded(
          albumModel: model, playListModel: null, imageUrl: imageUrl));
    } else if (responce != null) {
      emit(FetchSongError(
          error: StatusCodeHandler().getErrorMessage(responce.statusCode)));
    } else {
      emit(FetchSongError(error: "Not responding"));
    }
  }

//----------Fetch playlist by id ---------------
  void fetchPlayList({required String id, required String imageUrl}) async {
    emit(FetchSongLoading());
    final Response? responce = await Saavan2.fetchPlayList(playlistId: id);
    if (responce != null && responce.statusCode == 200) {
      final data = jsonDecode(responce.body);
      PlayListModel model = PlayListModel.fromJson(data);
      log("${model.data?.songs?.length}");
      emit(FetchAlbumAndPlayListLoaded(
          albumModel: null, playListModel: model, imageUrl: imageUrl));
    } else if (responce != null) {
      emit(FetchSongError(
          error: StatusCodeHandler().getErrorMessage(responce.statusCode)));
    } else {
      emit(FetchSongError(error: "Not responding"));
    }
  }

//---------- Fetch Artis by id ------------
  void FetchArtistSongs({required String id, required String imageUrl}) async {
    emit(FetchSongLoading());
    log("set");
    final Response? responce = await Saavan2.fetchArtist(artistId: id);
    log("----------${responce?.statusCode}");
    if (responce != null && responce.statusCode == 200) {
      final data = jsonDecode(responce.body);
      ArtistModel model = ArtistModel.fromJson(data);
      emit(FetchArtistLoadedState(model: model));
    } else if (responce != null) {
      emit(FetchSongError(
          error: StatusCodeHandler().getErrorMessage(responce.statusCode)));
    } else {
      emit(FetchSongError(error: "Not responding"));
    }
  }

//---------- Fetch song by id ------------
  void fetchSongById({required String id}) async {
    log("----song");
    emit(FetchSongLoading());
    final Response? responce = await Saavan2.fetchSong(songId: id);
    if (responce != null && responce.statusCode == 200) {
      final data = jsonDecode(responce.body);
      if (data["data"] is List) {
        List<Song> songs = (data["data"] as List)
            .map((songJson) => Song.fromJson(songJson as Map<String, dynamic>))
            .toList();
        emit(FetchSongByIDLoaded(songs: songs));
      } else {
        final Song model = Song.fromJson(data["data"]);
        emit(FetchSongByIDLoaded(songs: [model]));
      }
    } else if (responce != null) {
      emit(FetchSongError(
          error: StatusCodeHandler().getErrorMessage(responce.statusCode)));
    } else {
      emit(FetchSongError(error: "Not responding"));
    }
  }
}
