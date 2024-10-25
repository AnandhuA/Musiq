part of 'featch_album_and_play_list_cubit.dart';

@immutable
sealed class FeatchAlbumAndPlayListState {}

final class FeatchAlbumAndPlayListInitial extends FeatchAlbumAndPlayListState {}

final class FeatchAlbumAndPlayListLoading extends FeatchAlbumAndPlayListState {}

final class FeatchAlbumAndPlayListLoaded extends FeatchAlbumAndPlayListState {
  final AlbumModel? albumModel;
  final PlayListModel? playListModel;
  final String imageUrl;

  FeatchAlbumAndPlayListLoaded({
    required this.albumModel,
    required this.playListModel,
    required this.imageUrl,
  });
}

final class FeatchSongByIDLoaded extends FeatchAlbumAndPlayListState {
  final List<Song> songs;

  FeatchSongByIDLoaded({required this.songs});
}

final class FeatchAlbumAndPlayListError extends FeatchAlbumAndPlayListState {}
