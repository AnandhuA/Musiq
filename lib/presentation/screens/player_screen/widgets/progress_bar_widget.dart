import 'package:audio_service/audio_service.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:musiq/core/colors.dart';
import 'package:musiq/models/song_model.dart';

class ProgressBarWidget extends StatelessWidget {
  const ProgressBarWidget(
      {super.key,
      required this.song,
      required AudioHandler audioPlayer,
      required this.progressDuration})
      : _audioPlayer = audioPlayer;

  final SongModel song;
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
      bufferedBarColor: Colors.grey,
      timeLabelType: TimeLabelType.totalTime,
      total: Duration(seconds: song.duration),
      thumbColor: theme.brightness == Brightness.dark ? white : black,
      progressBarColor: theme.brightness == Brightness.dark ? white : black,
      onSeek: (duration) {
        _audioPlayer.seek(duration);
      },
    );
  }
}
