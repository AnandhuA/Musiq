part of 'fetch_song_cubit.dart';

@immutable
sealed class FetchSongState {}

final class FetchSongInitial extends FetchSongState {}

final class FetchSongLoading extends FetchSongState {}

final class FetchAlbumAndPlayListLoaded extends FetchSongState {
  final AlbumModel? albumModel;
  final PlayListModel? playListModel;
  final String imageUrl;

  FetchAlbumAndPlayListLoaded({
    required this.albumModel,
    required this.playListModel,
    required this.imageUrl,
  });
}

final class FetchArtistLoadedState extends FetchSongState {
  final ArtistModel model;

  FetchArtistLoadedState({required this.model});
}

final class FetchSongByIDLoaded extends FetchSongState {
  final List<Song> songs;

  FetchSongByIDLoaded({required this.songs});
}

final class FetchSongError extends FetchSongState {
  final String error;

  FetchSongError({required this.error});
  
}
