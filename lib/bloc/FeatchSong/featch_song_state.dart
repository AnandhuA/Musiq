part of 'featch_song_cubit.dart';

@immutable
sealed class FeatchSongState {}

final class FeatchSongInitial extends FeatchSongState {}

final class FeatchSongLoading extends FeatchSongState {}

final class FeatchAlbumAndPlayListLoaded extends FeatchSongState {
  final AlbumModel? albumModel;
  final PlayListModel? playListModel;
  final String imageUrl;

  FeatchAlbumAndPlayListLoaded({
    required this.albumModel,
    required this.playListModel,
    required this.imageUrl,
  });
}

final class FeatchArtistLoadedState extends FeatchSongState {
  final ArtistModel model;

  FeatchArtistLoadedState({required this.model});
}

final class FeatchSongByIDLoaded extends FeatchSongState {
  final List<Song> songs;

  FeatchSongByIDLoaded({required this.songs});
}

final class FeatchSongError extends FeatchSongState {
  final String error;

  FeatchSongError({required this.error});
  
}
