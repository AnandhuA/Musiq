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
  late String _currentSongTitle;
  late String _currentSongSubTitle;
  late String _imgUrl;

  @override
  void initState() {
    super.initState();
  }

  void _updateCurrentSongInfo() {
    if (lastplayedSong != null) {
      _currentSongTitle = lastplayedSong!.title;
      _currentSongSubTitle = lastplayedSong!.subtitle;
      _imgUrl = lastplayedSong!.imageUrl;
    } else {
      _currentSongTitle = 'No song playing';
      _currentSongSubTitle = '';
      _imgUrl = '';
    }
  }

  @override
  Widget build(BuildContext context) {
    _updateCurrentSongInfo();
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
          trailing: IconButton(
            icon: Icon(
              audioHandler.playbackState.value.playing
                  ? Icons.pause
                  : Icons.play_arrow,
            ),
            onPressed: _togglePlayPause,
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
