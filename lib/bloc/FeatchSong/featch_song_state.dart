part of 'featch_song_cubit.dart';

@immutable
sealed class FeatchSongState {}

final class FeatchSongInitial extends FeatchSongState {}

final class FeatchSongLoading extends FeatchSongState {}

final class FeatchSongLoaded extends FeatchSongState {
  final List<SongModel> songModel;

   FeatchSongLoaded({required this.songModel });
}



final class FeatchSongError extends FeatchSongState{
  
}