import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:musiq/core/colors.dart';
import 'package:musiq/models/song.dart';

class ProgressBarWidget extends StatelessWidget {
  const ProgressBarWidget(
      {super.key,
      required this.song,
      required AudioPlayer audioPlayer,
      required this.progressDuration})
      : _audioPlayer = audioPlayer;

  final Song song;
  final AudioPlayer _audioPlayer;
  final Duration progressDuration;

  @override
  Widget build(BuildContext context) {
    return ProgressBar(
      progress: progressDuration,
      timeLabelPadding: 5,
      barHeight: 3,
      thumbRadius: 7,
      buffered: progressDuration + const Duration(seconds: 30),
      bufferedBarColor: Colors.grey,
      timeLabelType: TimeLabelType.totalTime,
      total: Duration(seconds: song.duration ?? 00),
      thumbColor: white,
      progressBarColor: white,
      onSeek: (duration) {
        _audioPlayer.seek(duration);
      },
    );
  }
}
