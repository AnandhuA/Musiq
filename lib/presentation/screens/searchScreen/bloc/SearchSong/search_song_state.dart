part of 'search_song_bloc.dart';

@immutable
sealed class SearchSongState {}

final class SearchSongInitial extends SearchSongState {}

final class SearchSongLoading extends SearchSongState {}

final class SearchSongSuccess extends SearchSongState {
  final SearchModel searchResult;
  final List<SongModel> songModel;

  SearchSongSuccess({
    required this.searchResult,
    required this.songModel,
  });
}

final class SearchSongError extends SearchSongState {}
