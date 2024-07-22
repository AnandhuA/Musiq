part of 'english_song_suggestion_bloc.dart';

@immutable
sealed class EnglishSongSuggestionState {}

final class EnglishSongSuggestionInitial extends EnglishSongSuggestionState {}

final class EnglishSongSuggestionLoading extends EnglishSongSuggestionState {}

final class EnglishSongSuggestionLoaded extends EnglishSongSuggestionState {
  final List<Song> engSongs;

  EnglishSongSuggestionLoaded({required this.engSongs});
}

final class EnglishSongSuggestionError extends EnglishSongSuggestionState {}
