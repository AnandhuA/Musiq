part of 'tamil_song_bloc.dart';

@immutable
sealed class TamilSongState {}

final class TamilSongInitial extends TamilSongState {}

final class TamilSongLoading extends TamilSongState {}

final class TamilSongLoaded extends TamilSongState {
  final List<Song> songs;

  TamilSongLoaded({required this.songs});
}

final class TamilSongError extends TamilSongState {}
