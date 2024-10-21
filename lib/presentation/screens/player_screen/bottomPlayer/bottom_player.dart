import 'dart:async';
import 'package:audio_service/audio_service.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:musiq/core/colors.dart';
import 'package:musiq/core/helper_funtions.dart';
import 'package:musiq/main.dart';
import 'package:musiq/presentation/screens/player_screen/cubit/PlayAndPause/play_and_pause_cubit.dart';
import 'package:musiq/presentation/screens/player_screen/player_screen.dart';

class MiniPlayer extends StatefulWidget {
  final double bottomPosition;

  const MiniPlayer({
    Key? key,
    this.bottomPosition = 0,
  }) : super(key: key);

  @override
  _MiniPlayerState createState() => _MiniPlayerState();
}

class _MiniPlayerState extends State<MiniPlayer> {
  late String _currentSongTitle = 'No song playing';
  late String _currentSongSubTitle = '';
  late String _imgUrl = '';
  late StreamSubscription<PlaybackState> _playbackStateSubscription;
  late Duration _songDuration = Duration.zero;
  Duration _currentPosition = Duration.zero;

  @override
  void initState() {
    super.initState();
    _updateCurrentSongInfo();
    _playbackStateSubscription =
        audioHandler.playbackState.listen((playbackState) {
      bool isPlaying = playbackState.playing;
      Duration position = playbackState.updatePosition;
      Duration totalDuration =
          audioHandler.mediaItem.value?.duration ?? Duration.zero;

      context.read<PlayAndPauseCubit>().togglePlayerState(
            isPlaying: isPlaying,
            loading:
                playbackState.processingState == AudioProcessingState.loading,
          );
      if (playbackState.processingState == AudioProcessingState.completed) {
        setState(() {
          _updateCurrentSongInfo();
          _currentPosition = Duration.zero;
        });
      } else {
        setState(() {
          _updateCurrentSongInfo();
          _currentPosition = position;
          _songDuration = totalDuration;
        });
      }
    });
  }

  @override
  void dispose() {
    _playbackStateSubscription.cancel();
    super.dispose();
  }

  void _updateCurrentSongInfo() {
    if (lastplayedSongNotifier.value.isNotEmpty) {
      _currentSongTitle = lastplayedSongNotifier.value[currentSongIndex].name??"No";
      _currentSongSubTitle =
          lastplayedSongNotifier.value[currentSongIndex].label??"No";
      _imgUrl = lastplayedSongNotifier.value[currentSongIndex].image?.last.imageUrl??errorImage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: widget.bottomPosition,
      left: 0,
      right: 0,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          border: Border.all(
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.grey.shade800
                : Colors.grey.shade400,
          ),
          color:
              Theme.of(context).brightness == Brightness.dark ? black : white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            ListTile(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PlayerScreen(
                        songs: lastplayedSongNotifier.value,
                        currentpostion: _currentPosition,
                        initialIndex: currentSongIndex,
                        shuffle: audioHandler.isShuffleOn(),
                      ),
                    ));
              },
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: CachedNetworkImage(
                  imageUrl: _imgUrl,
                  fit: BoxFit.cover,
                  placeholder: (context, url) =>
                      Image.asset("assets/images/song.png"),
                  errorWidget: (context, url, error) =>
                      Image.asset("assets/images/song.png"),
                ),
              ),
              title: Text(
                _currentSongTitle,
                maxLines: 1,
              ),
              subtitle: Text(
                _currentSongSubTitle,
                maxLines: 1,
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                      onPressed: () async {
                        await audioHandler.skipToPrevious();
                      },
                      icon: Icon(
                        Icons.fast_rewind_sharp,
                        size: 16,
                      )),
                  BlocBuilder<PlayAndPauseCubit, PlayAndPauseState>(
                    builder: (context, state) {
                      if (state is LoadingState) {
                        return Lottie.asset(
                          Theme.of(context).brightness == Brightness.dark
                              ? "assets/animations/light_music_loading.json"
                              : "assets/animations/dark_music_loading.json",
                          width: 60,
                          height: 60,
                        );
                      } else if (state is PlayingState) {
                        return IconButton(
                          icon: Icon(
                            Icons.play_circle_fill_rounded,
                            size: 40,
                          ),
                          onPressed: () {
                            audioHandler.play();
                          },
                        );
                      } else if (state is PausedState) {
                        return IconButton(
                          icon: Icon(
                            Icons.pause_circle_filled,
                            size: 40,
                          ),
                          onPressed: () {
                            audioHandler.pause();
                          },
                        );
                      }
                      return IconButton(
                        icon: Icon(Icons.error_outline_sharp),
                        onPressed: () {},
                      );
                    },
                  ),
                  IconButton(
                      onPressed: () async {
                        await audioHandler.skipToNext();
                      },
                      icon: Icon(
                        Icons.fast_forward_sharp,
                        size: 16,
                      ))
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2),
              child: ProgressBar(
                progress: _currentPosition,
                barHeight: 1,
                thumbRadius: 3,
                timeLabelLocation: TimeLabelLocation.none,
                total: _songDuration,
                thumbColor: colorList[colorIndex],
                progressBarColor: colorList[colorIndex],
                onSeek: (duration) {
                  audioHandler.seek(duration);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
