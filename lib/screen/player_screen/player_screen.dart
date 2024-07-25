import 'dart:ui';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musiq/core/sized.dart';
import 'package:musiq/models/song.dart';
import 'package:musiq/screen/commanWidgets/custom_app_bar.dart';
import 'package:musiq/screen/commanWidgets/favorite_icon.dart';
import 'package:musiq/screen/player_screen/cubit/PlayAndPause/play_and_pause_cubit.dart';
import 'package:musiq/screen/player_screen/cubit/ProgressBar/progress_bar_cubit.dart';
import 'package:musiq/screen/player_screen/widgets/progress_bar_widget.dart';

class PlayerScreen extends StatefulWidget {
  final Song song;
  const PlayerScreen({super.key, required this.song});

  @override
  State<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  late AudioPlayer _audioPlayer;
  // Duration _currentPosition = Duration.zero;
  // PlayerState _playerState = PlayerState.paused;
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
        context.read<PlayAndPauseCubit>().togglePlayerState(state);
      }
    });

    _audioPlayer.onPositionChanged.listen((position) {
      if (mounted) {
        context.read<ProgressBarCubit>().changeProgress(position);
      }
    });
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  // void _togglePlayPause() {
  //   if (_playerState == PlayerState.playing) {
  //     _audioPlayer.pause();
  //   } else {
  //     _audioPlayer.resume();
  //   }
  // }

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
                        fontSize: 50,
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
                    BlocBuilder<ProgressBarCubit, ProgressBarState>(
                      builder: (context, state) {
                        if (state is ProgressBarInitial) {
                          return ProgressBarWidget(
                            widget: widget,
                            audioPlayer: _audioPlayer,
                            progressDuration: state.progressDuration,
                          );
                        }
                        return ProgressBarWidget(
                          widget: widget,
                          audioPlayer: _audioPlayer,
                          progressDuration: Duration.zero,
                        );
                      },
                    ),
                    constHeight30,
                    Row(
                      children: [
                        FavoriteIcon(song: widget.song),
                        const Spacer(),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.skip_previous_rounded,
                            size: 50,
                          ),
                        ),
                        BlocBuilder<PlayAndPauseCubit, PlayAndPauseState>(
                          builder: (context, state) {
                            if (state is PlayingStae) {
                              return IconButton(
                                onPressed: () {
                                  _audioPlayer.resume();
                                },
                                icon: const Icon(
                                  Icons.play_circle_fill_rounded,
                                  size: 60,
                                ),
                              );
                            }
                            if (state is PausedState) {
                              return IconButton(
                                onPressed: () {
                                  _audioPlayer.pause();
                                },
                                icon: const Icon(
                                  Icons.pause_circle_filled,
                                  size: 60,
                                ),
                              );
                            }
                            return const CircularProgressIndicator();
                          },
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
