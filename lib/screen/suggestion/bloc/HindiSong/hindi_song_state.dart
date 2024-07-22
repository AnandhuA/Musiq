part of 'hindi_song_bloc.dart';

@immutable
sealed class HindiSongState {}

final class HindiSongInitial extends HindiSongState {}

final class HindiSongLoading extends HindiSongState {}

final class HindiSongLoaded extends HindiSongState {
  final List<Song> songs;

  HindiSongLoaded({required this.songs});
}

final class HindiSongError extends HindiSongState {}
