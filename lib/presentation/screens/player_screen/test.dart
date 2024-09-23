// music_player_screen.dart
import 'package:flutter/material.dart';
import 'package:audio_service/audio_service.dart';
import 'package:musiq/models/song_model.dart';
import 'package:musiq/services/audio_handler.dart';

class MusicPlayerScreen extends StatefulWidget {
  final SongModel song;

  MusicPlayerScreen({required this.song});

  @override
  _MusicPlayerScreenState createState() => _MusicPlayerScreenState();
}

class _MusicPlayerScreenState extends State<MusicPlayerScreen> {
  late AudioPlayerHandler _audioHandler;
  late Stream<PlaybackState> _playbackStateStream;

  @override
  void initState() {
    super.initState();
    _audioHandler = AudioPlayerHandler();
    _playbackStateStream = _audioHandler.playbackState;
    _audioHandler.playUrl(widget.song.url); // Play the song using its URL
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.song.title),
      ),
      body: StreamBuilder<PlaybackState>(
        stream: _playbackStateStream,
        builder: (context, snapshot) {
          final playbackState = snapshot.data;
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                playbackState?.playing == true ? 'Now Playing' : 'Paused',
                style: TextStyle(fontSize: 24),
              ),
              SizedBox(height: 20),
              Slider(
                value:
                    playbackState?.updatePosition.inSeconds.toDouble() ?? 0.0,
                min: 0,
                max: widget.song.duration.toDouble(), // Use the song's duration
                onChanged: (value) {
                  final position = Duration(seconds: value.toInt());
                  _audioHandler.seek(position);
                },
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: Icon(Icons.pause),
                    onPressed: () {
                      _audioHandler.pause();
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.play_arrow),
                    onPressed: () {
                      _audioHandler.play();
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.stop),
                    onPressed: () {
                      _audioHandler.stop();
                    },
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
