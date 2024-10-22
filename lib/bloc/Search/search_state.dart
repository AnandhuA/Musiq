part of 'search_cubit.dart';

@immutable
sealed class SearchState {}

final class SearchInitial extends SearchState {}

final class SearchLoadingState extends SearchState {}

final class SearchLoadedState extends SearchState {}

final class SearchErrorState extends SearchState {}
