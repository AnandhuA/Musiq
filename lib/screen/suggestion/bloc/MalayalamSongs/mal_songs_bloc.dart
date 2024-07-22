import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:musiq/core/urls.dart';
import 'package:musiq/data/featch_suggetions.dart';

import 'package:musiq/models/song.dart';

part 'mal_songs_event.dart';
part 'mal_songs_state.dart';

class MalSongsBloc extends Bloc<MalSongsEvent, MalSongsState> {
  MalSongsBloc() : super(MalSongsInitial()) {
    on<MalSongsEvent>((event, emit) async {
      emit(MalSongsLoading());
      final Response? suggetionResponce =
          await FeatchSuggetions.featchSuggetions(url: suggestionMalUrl);

      if (suggetionResponce != null) {
        final Map<String, dynamic> decodedSuggetionResponse =
            jsonDecode(suggetionResponce.body);
        switch (suggetionResponce.statusCode) {
          case 200:
            final List<Song> suggetionSongs =
                (decodedSuggetionResponse['data'] as List)
                    .map((songJson) => Song.fromJson(songJson))
                    .toList();
            emit(MalSongsLoaded(songs: suggetionSongs));
            break;

          default:
        }
      } else {
        emit(MalSongsError());
      }
    });
  }
}
