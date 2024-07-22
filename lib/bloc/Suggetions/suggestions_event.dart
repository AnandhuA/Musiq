part of 'suggestions_bloc.dart';

@immutable
sealed class SuggestionsEvent {}

class FetchSuggestionsEvent extends SuggestionsEvent {}
