import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:musiq/core/colors.dart';
import 'package:musiq/main.dart';
import 'package:musiq/screen/player_screen/player_screen.dart';

class ProgressBarWidget extends StatelessWidget {
  const ProgressBarWidget(
      {super.key,
      required this.widget,
      required AudioPlayer audioPlayer,
      required this.progressDuration})
      : _audioPlayer = audioPlayer;

  final PlayerScreen widget;
  final AudioPlayer _audioPlayer;
  final Duration progressDuration;

  @override
  Widget build(BuildContext context) {
    return ProgressBar(
      progress: progressDuration,
      timeLabelPadding: 5,
      buffered: progressDuration + const Duration(seconds: 30),
      bufferedBarColor: Colors.grey,
      timeLabelType: TimeLabelType.totalTime,
      total: Duration(seconds: widget.song.duration ?? 00),
      onSeek: (duration) {
        _audioPlayer.seek(duration);
      },
      progressBarColor: accentColors[colorIndex],
      thumbColor: accentColors[colorIndex],
    );
  }
}
