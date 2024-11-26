part of 'home_screen_cubit.dart';

@immutable
sealed class HomeScreenState {}

final class HomeScreenInitial extends HomeScreenState {}

final class HomeScreenLoading extends HomeScreenState {}

final class HomeScreenLoaded extends HomeScreenState {
  final NewHomeScreenModel? newHomeScreenModel;
  final List<Song>? lastPlayedSongList;
  final List<PlaylistModelHive>? playList;

  HomeScreenLoaded(
      {required this.newHomeScreenModel,
      required this.lastPlayedSongList,
      required this.playList});
}

final class HomeScreenError extends HomeScreenState {
  final String error;
  final List<Song>? lastPlayedSongList;
  final List<PlaylistModelHive>? playList;

  HomeScreenError({
    required this.error,
    required this.lastPlayedSongList,
    required this.playList,
  });
}
