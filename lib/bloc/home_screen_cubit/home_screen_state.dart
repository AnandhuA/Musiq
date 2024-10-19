part of 'home_screen_cubit.dart';

@immutable
sealed class HomeScreenState {}

final class HomeScreenInitial extends HomeScreenState {}

final class HomeScreenLoading extends HomeScreenState {}

final class HomeScreenLoaded extends HomeScreenState {
  final HomeScreenModel homeScreenModel;
  final List<SongModel> lastplayed;
  final NewHomeScreenModel? newHomeScreenModel;

  HomeScreenLoaded({
    required this.homeScreenModel,
    required this.lastplayed,
    required this.newHomeScreenModel
  });
}

final class HomeScreenError extends HomeScreenState {}
