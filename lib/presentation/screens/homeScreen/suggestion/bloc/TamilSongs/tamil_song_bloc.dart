import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:musiq/core/urls.dart';
import 'package:musiq/data/featch_suggetions.dart';
import 'package:musiq/models/song.dart';


part 'tamil_song_event.dart';
part 'tamil_song_state.dart';

class TamilSongBloc extends Bloc<TamilSongEvent, TamilSongState> {
  TamilSongBloc() : super(TamilSongInitial()) {
    on<TamilSongEvent>((event, emit) async{
      emit(TamilSongLoading());
      final Response? suggetionResponce =
          await FeatchSuggetions.featchSuggetions(url: suggestionTamilUrl);

      if (suggetionResponce != null) {
        final Map<String, dynamic> decodedSuggetionResponse =
            jsonDecode(suggetionResponce.body);
        switch (suggetionResponce.statusCode) {
          case 200:
            final List<Song> suggetionSongs =
                (decodedSuggetionResponse['data'] as List)
                    .map((songJson) => Song.fromJson(songJson))
                    .toList();
            emit(TamilSongLoaded(songs: suggetionSongs));
            break;

          default:
        }
      } else {
        emit(TamilSongError());
      }
    });
  }
}
