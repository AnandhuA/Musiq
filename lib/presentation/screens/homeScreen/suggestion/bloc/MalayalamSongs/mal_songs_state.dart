part of 'mal_songs_bloc.dart';

@immutable
sealed class MalSongsState {}

final class MalSongsInitial extends MalSongsState {}

final class MalSongsLoading extends MalSongsState {}

final class MalSongsLoaded extends MalSongsState {
  final List<Song> songs;

  MalSongsLoaded({required this.songs});
}

final class MalSongsError extends MalSongsState {}
