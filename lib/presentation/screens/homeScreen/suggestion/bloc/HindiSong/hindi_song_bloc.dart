import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:musiq/core/urls.dart';
import 'package:musiq/data/featch_suggetions.dart';
import 'package:musiq/models/song.dart';

part 'hindi_song_event.dart';
part 'hindi_song_state.dart';

class HindiSongBloc extends Bloc<HindiSongEvent, HindiSongState> {
  HindiSongBloc() : super(HindiSongInitial()) {
    on<HindiSongEvent>((event, emit)async {
      emit(HindiSongLoading());
      final Response? suggetionResponce =
          await FeatchSuggetions.featchSuggetions(url: suggestionHindiUrl);

      if (suggetionResponce != null) {
        final Map<String, dynamic> decodedSuggetionResponse =
            jsonDecode(suggetionResponce.body);
        switch (suggetionResponce.statusCode) {
          case 200:
            final List<Song> suggetionSongs =
                (decodedSuggetionResponse['data'] as List)
                    .map((songJson) => Song.fromJson(songJson))
                    .toList();
            emit(HindiSongLoaded(songs: suggetionSongs));
            break;

          default:
        }
      } else {
        emit(HindiSongError());
      }
    });
  }
}
