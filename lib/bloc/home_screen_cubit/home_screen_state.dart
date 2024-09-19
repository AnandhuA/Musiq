part of 'home_screen_cubit.dart';

@immutable
sealed class HomeScreenState {}

final class HomeScreenInitial extends HomeScreenState {}



final class HomeScreenLoading extends HomeScreenState {}

final class HomeScreenLoaded extends HomeScreenState {
  final HomeScreenModel homeScreenModel;

 HomeScreenLoaded({required this.homeScreenModel});
}

final class HomeScreenError extends HomeScreenState {}
