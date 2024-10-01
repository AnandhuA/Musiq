import 'dart:async';

import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:musiq/core/colors.dart';
import 'package:musiq/main.dart';

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
                    size: 18,
                  )),
              IconButton(
                icon: Icon(
                  audioHandler.playbackState.value.playing
                      ? Icons.pause
                      : Icons.play_arrow,
                ),
                onPressed: _togglePlayPause,
              ),
              IconButton(
                  onPressed: () async {
                    await audioHandler.skipToNext();
                  },
                  icon: Icon(
                    Icons.fast_forward_sharp,
                    size: 18,
                  ))
            ],
          ),
        ),
      ),
    );
  }

  void _togglePlayPause() {
    if (audioHandler.playbackState.value.playing) {
      audioHandler.pause();
    } else {
      audioHandler.play();
    }
    setState(() {});
  }
}
