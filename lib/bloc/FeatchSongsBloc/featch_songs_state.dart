part of 'featch_songs_bloc.dart';

@immutable
sealed class FeatchSongsState {}

final class FeatchSongsInitial extends FeatchSongsState {}

final class FeatchSongsLoading extends FeatchSongsState {}

final class FeatchSongsSuccess extends FeatchSongsState {
  final List<SongModel> songList;

  FeatchSongsSuccess({required this.songList});
}

final class FeatchSongsFailure extends FeatchSongsState {}
