import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';


part 'play_and_pause_state.dart';

class PlayAndPauseCubit extends Cubit<PlayAndPauseState> {
  PlayAndPauseCubit() : super(PlayAndPauseInitial());

  void togglePlayerState(bool isPlaying) {
    if (isPlaying) {
      emit(PausedState());
    } else {
      emit(PlayingState());
    }
  }

  void reset() {
    emit(PlayAndPauseInitial());
  }
}
