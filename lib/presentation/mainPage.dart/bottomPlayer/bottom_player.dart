import 'dart:async';

import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:musiq/core/colors.dart';
import 'package:musiq/main.dart';
import 'package:musiq/presentation/screens/player_screen/cubit/PlayAndPause/play_and_pause_cubit.dart';

class MiniPlayer extends StatefulWidget {
  final Function()? onTap;
  final double bottomPostion;

  const MiniPlayer({
    Key? key,
    this.onTap,
    this.bottomPostion = 0,
  }) : super(key: key);

  @override
  _MiniPlayerState createState() => _MiniPlayerState();
}

class _MiniPlayerState extends State<MiniPlayer> {
  late String _currentSongTitle = 'No song playing';
  late String _currentSongSubTitle = '';
  late String _imgUrl = '';
  late StreamSubscription<PlaybackState> _playbackStateSubscription;

  @override
  void initState() {
    super.initState();
    _updateCurrentSongInfo();
    _playbackStateSubscription =
        audioHandler.playbackState.listen((playbackState) {
      bool isPlaying = playbackState.playing;
      // Duration position = playbackState.updatePosition;
      AudioProcessingState processingState = playbackState.processingState;
      bool loading = processingState == AudioProcessingState.loading;

      context.read<PlayAndPauseCubit>().togglePlayerState(
            isPlaying: isPlaying,
            loading: loading,
          );
      if (playbackState.processingState == AudioProcessingState.completed) {
        setState(() {
          _updateCurrentSongInfo();
        });
      } else {
        setState(() {
          _updateCurrentSongInfo();
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
    if (lastplayedSong != null) {
      _currentSongTitle = lastplayedSong!.title;
      _currentSongSubTitle = lastplayedSong!.subtitle;
      _imgUrl = lastplayedSong!.imageUrl;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: widget.bottomPostion,
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
        child: ListTile(
          onTap: () {
            if (widget.onTap != null) {
              widget.onTap!();
            }
          },
//---------- image ---------------
          leading: Container(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: CachedNetworkImage(
                imageUrl: _imgUrl,
                fit: BoxFit.fitWidth,
                placeholder: (context, url) =>
                    Image.asset("assets/images/song.png"),
                errorWidget: (context, url, error) =>
                    Image.asset("assets/images/song.png"),
              ),
            ),
          ),
//-------- title ---------
          title: Text(
            _currentSongTitle,
            maxLines: 1,
          ),
//--------- sub title -----------
          subtitle: Text(
            _currentSongSubTitle,
            maxLines: 1,
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
//------------- previous song icon -------------
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
//----------------  if state is loading  show loading -------------------
                  if (state is LoadingState) {
                    return Theme.of(context).brightness == Brightness.dark
                        ? Lottie.asset(
                            "assets/animations/light_music_loading.json",
                            width: 60,
                            height: 60,
                          )
                        : Lottie.asset(
                            "assets/animations/dark_music_loading.json",
                            width: 60,
                            height: 60,
                          );
                  }
// ----------  if state is playingState  show play button
                  else if (state is PlayingState) {
                    return IconButton(
                      icon: Icon(
                        Icons.play_circle_fill_rounded,
                        size: 40,
                      ),
                      onPressed: () {
                        audioHandler.play();
                      },
                    );
                  }
//----------------if state is pauseState show pause button
                  else if (state is PausedState) {
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
//------------ error icon -------------
                  return IconButton(
                    icon: Icon(
                      Icons.error_outline_sharp,
                    ),
                    onPressed: () {},
                  );
                },
              ),
//----------- next song icon --------------
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
      ),
    );
  }
}
