part of 'home_screen_cubit.dart';

@immutable
sealed class HomeScreenState {}

final class HomeScreenInitial extends HomeScreenState {}

final class HomeScreenLoading extends HomeScreenState {}

final class HomeScreenLoaded extends HomeScreenState {

  final NewHomeScreenModel? newHomeScreenModel;

  HomeScreenLoaded({
   
    required this.newHomeScreenModel,
  });
}

final class HomeScreenError extends HomeScreenState {}
