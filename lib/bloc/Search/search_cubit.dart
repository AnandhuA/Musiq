import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:http/http.dart';
import 'package:meta/meta.dart';
import 'package:musiq/data/savan_2.0.dart';
import 'package:musiq/models/global_search_model/global_search_model.dart';
import 'package:musiq/models/search_album_model/search_album_model.dart';
import 'package:musiq/models/search_play_list_model/search_play_list_model.dart';
import 'package:musiq/models/search_song_model/search_song_model.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitial());
// ----- gobal search -------------
  void searchGobal({required String query}) async {
    final Response? response = await Saavan2.featchglobalSearch(query: query);
    if (response != null && response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final GlobalSearchModel model = GlobalSearchModel.fromJson(data);
      log("-------${model.data?.songs?.results?.length}");
    }
  }

// --------- search song --------------
  void searchSong({required String query}) async {
    final Response? responce = await Saavan2.featchSearchSong(query: query);
    if (responce != null && responce.statusCode == 200) {
      final data = jsonDecode(responce.body);
      final SearchSongModel model = SearchSongModel.fromJson(data);
      log("------------${model.data?.results?.length}");
    }
  }

// ---------- search album -----------
  void searchAlbum({required String query}) async {
    final Response? responce = await Saavan2.featchSearchAlbums(query: query);
    if (responce != null && responce.statusCode == 200) {
      final data = jsonDecode(responce.body);
      final SearchAlbumModel model = SearchAlbumModel.fromJson(data);
      log("------------${model.data?.results?.length}");
    }
  }

//--------------- search playList ----------
  void searchPlayList({required String query}) async {
    final Response? responce = await Saavan2.featchSearchPlayList(query: query);
    if (responce != null && responce.statusCode == 200) {
      final data = jsonDecode(responce.body);
      final SearchPlayListModel model = SearchPlayListModel.fromJson(data);
      log("------------${model.data?.results?.length}");
    }
  }
}
