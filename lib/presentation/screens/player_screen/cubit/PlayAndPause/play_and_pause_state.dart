part of 'play_and_pause_cubit.dart';

@immutable
sealed class PlayAndPauseState {}

final class PlayAndPauseInitial extends PlayAndPauseState {
  final PlayerState playerState;

  PlayAndPauseInitial({required this.playerState});
}

final class PlayingStae extends PlayAndPauseState {

}

final class PausedState extends PlayAndPauseState {
  
}