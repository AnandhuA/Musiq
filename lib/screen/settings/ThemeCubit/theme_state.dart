part of 'theme_cubit.dart';

@immutable
sealed class ThemeState {}

final class ThemeInitial extends ThemeState {
  final String? theme;

  ThemeInitial({required this.theme});
}
