part of 'progress_bar_cubit.dart';

@immutable
sealed class ProgressBarState {}

final class ProgressBarInitial extends ProgressBarState {
  final Duration progressDuration;

  ProgressBarInitial({required this.progressDuration});
}
