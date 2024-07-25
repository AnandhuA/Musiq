part of 'favorite_bloc.dart';

@immutable
sealed class FavoriteEvent {}

final class FeatchFavoriteSongEvent extends FavoriteEvent {}

final class AddFavoriteEvent extends FeatchFavoriteSongEvent {
  final Song song;

  AddFavoriteEvent({required this.song});
}

final class RemoveFavoriteEvent extends FeatchFavoriteSongEvent {
  final Song song;

  RemoveFavoriteEvent({required this.song});
}
