part of 'favorite_bloc.dart';

@immutable
sealed class FavoriteEvent {}

final class FeatchFavoriteSongEvent extends FavoriteEvent {}

final class AddFavoriteEvent extends FavoriteEvent {
  final SongModel song;

  AddFavoriteEvent({required this.song});
}

final class RemoveFavoriteEvent extends FavoriteEvent {
  final SongModel song;

  RemoveFavoriteEvent({required this.song});
}

final class SearchFavoriteEvent extends FavoriteEvent {
  final String query;

  SearchFavoriteEvent({required this.query});
}

class SortFavoriteEvent extends FavoriteEvent {
  final SortType sortType;
  final bool ascending;

  SortFavoriteEvent({required this.sortType, this.ascending = true});
}

enum SortType { name, time }

class SortOption {
  final String key;
  final SortType sortType;
  final bool ascending;

  SortOption({
    required this.key,
    required this.sortType,
    required this.ascending,
  });
}
