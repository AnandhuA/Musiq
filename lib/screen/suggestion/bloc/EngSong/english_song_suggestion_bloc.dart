import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:musiq/core/urls.dart';
import 'package:musiq/data/featch_suggetions.dart';

import 'package:musiq/models/song.dart';

part 'english_song_suggestion_event.dart';
part 'english_song_suggestion_state.dart';

class EnglishSongSuggestionBloc extends Bloc<EnglishSongSuggestionEvent, EnglishSongSuggestionState> {
  EnglishSongSuggestionBloc() : super(EnglishSongSuggestionInitial()) {
    on<EnglishSongSuggestionEvent>((event, emit) async{
     emit(EnglishSongSuggestionLoading());
    final Response? suggetionResponce =
        await FeatchSuggetions.featchSuggetions(url: suggestionEnglishUrl);
        
    if (suggetionResponce != null) {
      final Map<String, dynamic> decodedSuggetionResponse =
          jsonDecode(suggetionResponce.body);
      switch (suggetionResponce.statusCode) {
        case 200:
          final List<Song> suggetionSongs = (decodedSuggetionResponse['data'] as List)
              .map((songJson) => Song.fromJson(songJson))
              .toList();
          emit(EnglishSongSuggestionLoaded(engSongs: suggetionSongs));
          break;

        default:
      }
    } else {
      emit(EnglishSongSuggestionError());
    }
    });
  }
}
