part of 'search_cubit.dart';

@immutable
sealed class SearchState {}

final class SearchInitial extends SearchState {}

final class SearchLoadingState extends SearchState {}

final class SearchLoadedState extends SearchState {}

final class SearchErrorState extends SearchState {}

final class GobalSearchState extends SearchState {
  final GlobalSearchModel model;

  GobalSearchState({required this.model});
  
}

final class SongSearchState extends SearchState {
  final SearchSongModel model;

  SongSearchState({required this.model});
}

final class AlbumSearchState extends SearchState {
  final SearchAlbumModel model;

  AlbumSearchState({required this.model});
}

final class ArtistSearchState extends SearchState {
  final SearchArtistModel model;

  ArtistSearchState({required this.model});
}

final class PlayListSearchState extends SearchState {
  final SearchPlayListModel model;

  PlayListSearchState({required this.model});
}
