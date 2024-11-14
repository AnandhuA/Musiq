import 'package:audio_service/audio_service.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:musiq/core/colors.dart';

class ProgressBarWidget extends StatelessWidget {
  const ProgressBarWidget(
      {super.key,
      required this.songDuration,
      required AudioHandler audioPlayer,
      required this.progressDuration})
      : _audioPlayer = audioPlayer;

  final Duration songDuration;
  final AudioHandler _audioPlayer;
  final Duration progressDuration;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ProgressBar(
      progress: progressDuration,
      timeLabelPadding: 5,
      barHeight: 3,
      thumbRadius: 7,
      buffered: progressDuration + const Duration(seconds: 30),
      bufferedBarColor: AppColors.grey,
      timeLabelType: TimeLabelType.totalTime,
      total: songDuration,
      thumbColor: theme.brightness == Brightness.dark
          ? AppColors.white
          : AppColors.black,
      progressBarColor: theme.brightness == Brightness.dark
          ? AppColors.white
          : AppColors.black,
      onSeek: (duration) {
        _audioPlayer.seek(duration);
      },
    );
  }
}
