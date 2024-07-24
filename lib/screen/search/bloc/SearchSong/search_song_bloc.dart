import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:musiq/data/search_song.dart';
import 'package:musiq/models/song.dart';

part 'search_song_event.dart';
part 'search_song_state.dart';

class SearchSongBloc extends Bloc<SearchSongEvent, SearchSongState> {
  SearchSongBloc() : super(SearchSongInitial()) {
    on<SearchSongEvent>((event, emit) async {
      emit(SearchSongLoading());
      Response? searchResponse =
          await SearchSong.searchSong(data: event.searchQuery);
      if (searchResponse != null) {
        final decodedSeachResult = jsonDecode(searchResponse.body);

        if (decodedSeachResult["data"]['results'] != null) {
          switch (searchResponse.statusCode) {
            case 200:
              final List<Song> songs =
                  (decodedSeachResult["data"]['results'] as List)
                      .map((songJson) => Song.fromJson(songJson))
                      .toList();

              emit(SearchSongSuccess(searchResult: songs));
              break;

            default:
          }
        } else {
          emit(SearchSongError());
        }
      } else {
        emit(SearchSongError());
      }
    });
  }
}
