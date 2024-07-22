import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:musiq/data/featch_suggetions.dart';
import 'package:musiq/models/song.dart';

part 'suggestions_event.dart';
part 'suggestions_state.dart';

class SuggestionsBloc extends Bloc<SuggestionsEvent, SuggestionsState> {
  SuggestionsBloc() : super(SuggestionsInitial()) {
    on<FetchSuggestionsEvent>(_featchSuggetions);
  }

  FutureOr<void> _featchSuggetions(
    FetchSuggestionsEvent event,
    Emitter<SuggestionsState> emit,
  ) async {
    emit(SuggestionsLoading());
    final Response? suggetionResponce =
        await FeatchSuggetions.featchSuggetions();
    if (suggetionResponce != null) {
      final Map<String, dynamic> decodedSuggetionResponse =
          jsonDecode(suggetionResponce.body);
      switch (suggetionResponce.statusCode) {
        case 200:
          final List<Song> suggetionSongs = (decodedSuggetionResponse['data'] as List)
              .map((songJson) => Song.fromJson(songJson))
              .toList();
          emit(SuggestionsLoaded(suggetionSongs: suggetionSongs));
          break;

        default:
      }
    } else {
      emit(SuggestionsError());
    }
  }
}
