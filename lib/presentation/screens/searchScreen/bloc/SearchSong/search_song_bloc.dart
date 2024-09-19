import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musiq/data/saavn_data.dart';
import 'package:musiq/models/search_model.dart';

part 'search_song_event.dart';
part 'search_song_state.dart';

class SearchSongBloc extends Bloc<SearchSongEvent, SearchSongState> {
  SearchSongBloc() : super(SearchSongInitial()) {
    on<SearchSongEvent>((event, emit) async {
      emit(SearchSongLoading());
      try {
        final searchData =
            await SaavnAPI().fetchSearchResults(event.searchQuery);
        final searchModel = SearchModel.fromJson(searchData);
        emit(SearchSongSuccess(searchResult: searchModel));
      } catch (e) {
        log("Error fetching search results: $e");
        emit(SearchSongError());
      }
    });
  }
}
