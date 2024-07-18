import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:musiq/data/featch_data.dart';
import 'package:musiq/models/song_model.dart';

part 'featch_songs_event.dart';
part 'featch_songs_state.dart';

class FeatchSongsBloc extends Bloc<FeatchSongsEvent, FeatchSongsState> {
  FeatchSongsBloc() : super(FeatchSongsInitial()) {
    on<FeatchSongsEvent>((event, emit) async {
      // return emit(FeatchSongsFailure());
      emit(FeatchSongsLoading());
      final List<SongModel>? songList =
          await fetchAllMusicFilesAndPrintMetadata();
      if (songList != null) {
        log(songList.length.toString());
        emit(FeatchSongsSuccess(songList: songList));
      } else {
        emit(FeatchSongsFailure());
      }
    });
  }
}
