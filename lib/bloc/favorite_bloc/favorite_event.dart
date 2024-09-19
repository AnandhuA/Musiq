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
