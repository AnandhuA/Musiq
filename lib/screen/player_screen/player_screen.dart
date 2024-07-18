import 'package:flutter/material.dart';
import 'package:musiq/models/song_model.dart';
import 'package:audioplayers/audioplayers.dart';

class PlayerScreen extends StatefulWidget {
  final List<SongModel> songList;
  final int currentIndex;
  const PlayerScreen({
    super.key,
    required this.songList,
    required this.currentIndex,
  });

  @override
  State<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  late AudioPlayer _audioPlayer;
  bool _isPlaying = false;
  Duration _duration = Duration.zero;
  Duration _position = Duration.zero;

  @override
  void initState() {
    super.initState();

    _audioPlayer = AudioPlayer();
    _audioPlayer.play(UrlSource(widget.songList[widget.currentIndex].songUrls));
    _audioPlayer.onDurationChanged.listen((Duration d) {
      if (mounted) {
        setState(() {
          _duration = d;
        });
      }
    });

    _audioPlayer.onPositionChanged.listen((Duration p) {
      if (mounted) {
        setState(() {
          _position = p;
        });
      }
    });

    _audioPlayer.onPlayerStateChanged.listen((PlayerState state) {
      if (mounted) {
        setState(() {
          _isPlaying = state == PlayerState.playing;
        });
      }
    });
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  void _playPause() {
    if (_isPlaying) {
      _audioPlayer.pause();
    } else {
      _audioPlayer
          .play(UrlSource(widget.songList[widget.currentIndex].songUrls));
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.songList[widget.currentIndex].movie),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              SizedBox(
                height: size.height * 0.4,
                width: double.infinity,
                child: widget.songList[widget.currentIndex].imgFile != null
                    ? Image.memory(
                        widget.songList[widget.currentIndex].imgFile!)
                    : Image.asset("assets/images/music.jpg"),
              ),
              const SizedBox(height: 25),
              Text(
                widget.songList[widget.currentIndex].songName,
                style: const TextStyle(fontSize: 30),
              ),
              const SizedBox(height: 5),
              Text(
                widget.songList[widget.currentIndex].artist,
              ),
              const SizedBox(height: 20),
              Slider(
                min: 0.0,
                max: _duration.inSeconds.toDouble(),
                value: _position.inSeconds.toDouble(),
                onChanged: (double value) {
                  setState(() {
                    _audioPlayer.seek(Duration(seconds: value.toInt()));
                  });
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${_position.inMinutes}:${(_position.inSeconds.remainder(60)).toString().padLeft(2, '0')}',
                      style: const TextStyle(fontSize: 12),
                    ),
                    Text(
                      '${_duration.inMinutes}:${(_duration.inSeconds.remainder(60)).toString().padLeft(2, '0')}',
                      style: const TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: Icon(_isPlaying ? Icons.pause : Icons.play_arrow),
                    onPressed: _playPause,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
