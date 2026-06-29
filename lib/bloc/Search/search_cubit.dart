import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:musiq/data/yt_services/youtube_scraper_service.dart';
import 'package:musiq/models/global_search_model/global_search_model.dart';
import 'package:musiq/models/search_album_model/search_album_model.dart';
import 'package:musiq/models/search_artist_model/search_artist_model.dart';
import 'package:musiq/models/search_play_list_model/search_play_list_model.dart';
import 'package:musiq/models/search_song_model/data.dart' as song_search_data;
import 'package:musiq/models/search_song_model/search_song_model.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitial());
// ----- gobal search -------------
  void searchGobal({required String query}) async {
    searchSong(query: query);
  }

// --------- search song --------------
  void searchSong({required String query}) async {
    emit(SearchLoadingState());
    try {
      final songs = await YouTubeScraperService.instance.searchSongs(query);
      final SearchSongModel model = SearchSongModel(
        success: true,
        data: song_search_data.Data(
          total: songs.length,
          start: 0,
          results: songs,
        ),
      );
      log("youtube search --${model.data?.results?.length}");
      emit(SongSearchState(model: model));
    } catch (e) {
      emit(SearchErrorState(error: "YouTube search error: $e"));
    }
  }

// ---------- search album -----------
  void searchAlbum({required String query}) async {
    searchSong(query: query);
  }

//--------------- search playList ----------
  void searchPlayList({required String query}) async {
    searchSong(query: query);
  }

  void searchArtist({required String query}) async {
    searchSong(query: query);
  }
}
