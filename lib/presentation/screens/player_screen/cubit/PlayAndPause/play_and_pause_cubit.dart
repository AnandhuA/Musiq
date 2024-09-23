import 'package:bloc/bloc.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

part 'play_and_pause_state.dart';


class PlayAndPauseCubit extends Cubit<PlayAndPauseState> {
  PlayAndPauseCubit()
      : super(PlayAndPauseInitial(playerState: PlayerState.paused));

  void togglePlayerState(bool isPlaying) {
    if (isPlaying) {
      emit(PausedState());
    } else {
      emit(PlayingState());
    }
  }

  void reset() {
    emit(PlayAndPauseInitial(playerState: PlayerState.paused));
  }
}
