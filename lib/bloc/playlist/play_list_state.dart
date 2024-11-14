part of 'play_list_cubit.dart';

@immutable
sealed class PlayListState {}

final class PlayListInitial extends PlayListState {}

final class PlayListLoadingState extends PlayListState {}

final class FeatchPlayListSuccessState extends PlayListState {
  final List<PlaylistModelHive> playlistList;

  FeatchPlayListSuccessState({required this.playlistList});
}
