import 'dart:convert';
import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:http/http.dart';
import 'package:meta/meta.dart';
import 'package:musiq/core/helper_funtions.dart';
import 'package:musiq/data/savan_2.0.dart';
import 'package:musiq/models/global_search_model/global_search_model.dart';
import 'package:musiq/models/search_album_model/search_album_model.dart';
import 'package:musiq/models/search_artist_model/search_artist_model.dart';
import 'package:musiq/models/search_play_list_model/search_play_list_model.dart';
import 'package:musiq/models/search_song_model/search_song_model.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitial());
// ----- gobal search -------------
  void searchGobal({required String query}) async {
    emit(SearchLoadingState());
    final Response? response = await Saavan2.fetchglobalSearch(query: query);
    if (response != null && response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final GlobalSearchModel model = GlobalSearchModel.fromJson(data);
      emit(GobalSearchState(model: model));
    } else if (response != null) {
      emit(SearchErrorState(
          error: StatusCodeHandler().getErrorMessage(response.statusCode)));
    } else {
      emit(SearchErrorState(error: "Not responding"));
    }
  }

// --------- search song --------------
  void searchSong({required String query}) async {
    emit(SearchLoadingState());
    final Response? responce = await Saavan2.fetchSearchSong(query: query);
    if (responce != null && responce.statusCode == 200) {
      final data = jsonDecode(responce.body);
      final SearchSongModel model = SearchSongModel.fromJson(data);
      log("bloc --${model.data?.results?.length}");
      emit(SongSearchState(model: model));
    } else if (responce != null) {
      emit(SearchErrorState(
          error: StatusCodeHandler().getErrorMessage(responce.statusCode)));
    } else {
      emit(SearchErrorState(error: "Not responding"));
    }
  }

// ---------- search album -----------
  void searchAlbum({required String query}) async {
    emit(SearchLoadingState());
    final Response? responce = await Saavan2.fetchSearchAlbums(query: query);
    if (responce != null && responce.statusCode == 200) {
      final data = jsonDecode(responce.body);
      final SearchAlbumModel model = SearchAlbumModel.fromJson(data);
      emit(AlbumSearchState(model: model));
    } else if (responce != null) {
      emit(SearchErrorState(
          error: StatusCodeHandler().getErrorMessage(responce.statusCode)));
    } else {
      emit(SearchErrorState(error: "Not responding"));
    }
  }

//--------------- search playList ----------
  void searchPlayList({required String query}) async {
    emit(SearchLoadingState());
    final Response? responce = await Saavan2.fetchSearchPlayList(query: query);
    if (responce != null && responce.statusCode == 200) {
      final data = jsonDecode(responce.body);
      final SearchPlayListModel model = SearchPlayListModel.fromJson(data);
      emit(PlayListSearchState(model: model));
    } else if (responce != null) {
      emit(SearchErrorState(
          error: StatusCodeHandler().getErrorMessage(responce.statusCode)));
    } else {
      emit(SearchErrorState(error: "Not responding"));
    }
  }

  void searchArtist({required String query}) async {
    emit(SearchLoadingState());
    final Response? responce = await Saavan2.fetchSearchArtists(query: query);
    if (responce != null && responce.statusCode == 200) {
      final data = jsonDecode(responce.body);
      final SearchArtistModel model = SearchArtistModel.fromJson(data);
      emit(ArtistSearchState(model: model));
    } else if (responce != null) {
      emit(SearchErrorState(
          error: StatusCodeHandler().getErrorMessage(responce.statusCode)));
    } else {
      emit(SearchErrorState(error: "Not responding"));
    }
  }
}
