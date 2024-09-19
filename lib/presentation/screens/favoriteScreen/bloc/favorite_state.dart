part of 'favorite_bloc.dart';

@immutable
sealed class FavoriteState {}

final class FavoriteInitial extends FavoriteState {}

final class FavoriteLoading extends FavoriteState {}

final class FavoriteError extends FavoriteState {}

final class FeatchFavoriteSuccess extends FavoriteState {
  final  List<SongModel> favorites;

   FeatchFavoriteSuccess({required this.favorites });
}
final class AddFavoriteSuccess extends FavoriteState {}
final class RemoveFavoriteSuccess extends FavoriteState {}

// final class UserNotLoggedIn extends FavoriteState {}