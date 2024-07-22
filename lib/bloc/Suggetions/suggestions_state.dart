part of 'suggestions_bloc.dart';

@immutable
sealed class SuggestionsState {}

final class SuggestionsInitial extends SuggestionsState {}

final class SuggestionsLoading extends SuggestionsState {}

final class SuggestionsLoaded extends SuggestionsState {
  final List<Song> suggetionSongs;

  SuggestionsLoaded({required this.suggetionSongs});

}

final class SuggestionsError extends SuggestionsState {}
