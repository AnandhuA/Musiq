import 'package:bloc/bloc.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

part 'play_and_pause_state.dart';

class PlayAndPauseCubit extends Cubit<PlayAndPauseState> {
  PlayAndPauseCubit()
      : super(PlayAndPauseInitial(playerState: PlayerState.paused));

  void togglePlayerState(PlayerState state) {
    if (state == PlayerState.playing) {
      emit(PausedState());
    } else {
      emit(PlayingState());
    }
   
  }
}
