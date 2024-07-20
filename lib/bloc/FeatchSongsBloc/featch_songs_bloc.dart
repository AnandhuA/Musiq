// import 'dart:developer';

// import 'package:bloc/bloc.dart';
// import 'package:flutter/material.dart';
// import 'package:musiq/data/featch_data.dart';
// import 'package:musiq/models/song_model.dart';

// part 'featch_songs_event.dart';
// part 'featch_songs_state.dart';

// class FeatchSongsBloc extends Bloc<FeatchSongsEvent, FeatchSongsState> {
//   FeatchSongsBloc() : super(FeatchSongsInitial()) {
//     on<FeatchSongsEvent>((event, emit) async {
//       // return emit(FeatchSongsFailure());
//       emit(FeatchSongsLoading());
//       final List<SongModel>? songList =
//           await fetchAllMusicFilesAndPrintMetadata();
//       if (songList != null) {
//         log(songList.length.toString());
//         emit(FeatchSongsSuccess(songList: songList));
//       } else {
//         emit(FeatchSongsFailure());
//       }
//     });
//   }
// }
import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:musiq/data/featch_data.dart';
import 'package:musiq/models/song_model.dart';

part 'featch_songs_event.dart';
part 'featch_songs_state.dart';

class FeatchSongsBloc extends Bloc<FeatchSongsEvent, FeatchSongsState> {
  final StreamController<SongModel> _songStreamController =
      StreamController.broadcast();

  Stream<SongModel> get songStream => _songStreamController.stream;

  FeatchSongsBloc() : super(FeatchSongsInitial()) {
    on<FeatchSongsEvent>((event, emit) async {
      emit(FeatchSongsLoading());
      final List<SongModel>? songList = await fetchBasicSongMetadata();
      if (songList != null) {
        emit(FeatchSongsSuccess(songList: songList));
        _loadImages(songList);
      } else {
        emit(FeatchSongsFailure());
      }
    });
  }

  void _loadImages(List<SongModel> songList) async {
    for (var song in songList) {
      await loadSongImage(song); // Load image for each song
      _songStreamController.add(song); // Notify listeners about the image load
    }
  }

  @override
  Future<void> close() {
    _songStreamController.close();
    return super.close();
  }
}
