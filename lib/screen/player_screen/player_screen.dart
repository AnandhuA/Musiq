import 'dart:ui';

import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:musiq/core/colors.dart';
import 'package:musiq/core/sized.dart';
import 'package:musiq/main.dart';

import 'package:musiq/models/song.dart';
import 'package:musiq/screen/commanWidgets/custom_app_bar.dart';

class PlayerScreen extends StatefulWidget {
  final Song song;
  const PlayerScreen({super.key, required this.song});

  @override
  State<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  late AudioPlayer _audioPlayer;
  Duration _currentPosition = Duration.zero;
  PlayerState _playerState = PlayerState.paused;
  bool _hasPlayed = false;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();

    _audioPlayer
        .setSource(UrlSource(widget.song.downloadUrl.last.url))
        .then((_) {
      _audioPlayer.getDuration().then((duration) {});
      if (!_hasPlayed) {
        _audioPlayer.play(
          UrlSource(
            widget.song.downloadUrl.last.url,
          ),
        );
        setState(() {
          _hasPlayed = true;
        });
      }
    });

    _audioPlayer.onPlayerStateChanged.listen((state) {
      if (mounted) {
        setState(() {
          _playerState = state;
        });
      }
    });

    _audioPlayer.onPositionChanged.listen((position) {
      if (mounted) {
        setState(() {
          _currentPosition = position;
        });
      }
    });
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  void _togglePlayPause() {
    if (_playerState == PlayerState.playing) {
      _audioPlayer.pause();
    } else {
      _audioPlayer.resume();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(widget.song.image.first.url),
              alignment: const Alignment(1, -1),
              fit: BoxFit.fitWidth,
            ),
          ),
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 100,
              sigmaY: 100,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    CustomAppBar(
                      title: widget.song.album.name,
                    ),
                    Container(
                      height: 350,
                      width: 500,
                      margin: const EdgeInsets.all(30),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(
                            widget.song.image.last.url,
                          ),
                          fit: BoxFit.fill,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    constHeight20,
                    Text(
                      widget.song.name ?? "no name",
                      style: const TextStyle(
                        fontSize: 30,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.fade,
                      softWrap: false,
                    ),
                    constHeight10,
                    Text(
                      widget.song.artists.all
                          .map((artist) => artist.name)
                          .join(' | '),
                      maxLines: 1,
                      overflow: TextOverflow.fade,
                      softWrap: false,
                    ),
                    constHeight40,
                    ProgressBar(
                      progress: _currentPosition,
                      timeLabelPadding: 5,
                      buffered: _currentPosition + const Duration(seconds: 30),
                      bufferedBarColor: Colors.grey,
                      timeLabelType: TimeLabelType.totalTime,
                      total: Duration(seconds: widget.song.duration ?? 00),
                      onSeek: (duration) {
                        _audioPlayer.seek(duration);
                      },
                      progressBarColor: accentColors[colorIndex],
                      thumbColor: accentColors[colorIndex],
                    ),
                    constHeight30,
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.favorite_border,
                          ),
                        ),
                        const Spacer(),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.skip_previous_rounded,
                            size: 50,
                          ),
                        ),
                        IconButton(
                          onPressed: _togglePlayPause,
                          icon: Icon(
                            _playerState == PlayerState.playing
                                ? Icons.pause_circle_filled_rounded
                                : Icons.play_circle_fill_rounded,
                            size: 60,
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.skip_next_rounded,
                            size: 50,
                          ),
                        ),
                        const Spacer(),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.download,
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
//9745108597