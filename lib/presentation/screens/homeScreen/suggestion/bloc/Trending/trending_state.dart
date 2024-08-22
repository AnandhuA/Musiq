part of 'trending_cubit.dart';

@immutable
sealed class TrendingState {}

final class TrendingInitial extends TrendingState {}

final class TrendingLoading extends TrendingState {}

final class TrendingLoaded extends TrendingState {
  final List<Song> songs;

  TrendingLoaded({required this.songs});
}

final class TrendingError extends TrendingState {}
