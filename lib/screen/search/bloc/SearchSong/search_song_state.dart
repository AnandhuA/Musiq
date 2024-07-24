part of 'search_song_bloc.dart';

@immutable
sealed class SearchSongState {}

final class SearchSongInitial extends SearchSongState {}

final class SearchSongLoading extends SearchSongState {}

final class SearchSongSuccess extends SearchSongState {
  final List<Song> searchResult;

  SearchSongSuccess({required this.searchResult});
}

final class SearchSongError extends SearchSongState {}
