// State definitions
part of 'play_and_pause_cubit.dart';

@immutable
sealed class PlayAndPauseState {}

final class PlayAndPauseInitial extends PlayAndPauseState {}

final class PlayingState extends PlayAndPauseState {}

final class PausedState extends PlayAndPauseState {}

final class LoadingState extends PlayAndPauseState {}

final class PlayerLoadingState extends PlayAndPauseState {}

final class PlayerErrorState extends PlayAndPauseState {
  final String message;

  PlayerErrorState({required this.message});
}
