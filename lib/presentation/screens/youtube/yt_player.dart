import 'package:flutter/material.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import 'package:audioplayers/audioplayers.dart';

class YtMusicPlayerScreen extends StatefulWidget {
  final String videoId;
  final String title;
  final String thumbnailUrl;
  final String channelName;

  const YtMusicPlayerScreen({
    super.key,
    required this.videoId,
    required this.title,
    required this.thumbnailUrl,
    required this.channelName,
  });

  @override
  State<YtMusicPlayerScreen> createState() => _YtMusicPlayerScreenState();
}

class _YtMusicPlayerScreenState extends State<YtMusicPlayerScreen> {
  final YoutubeExplode _yt = YoutubeExplode();
  AudioPlayer _audioPlayer = AudioPlayer();
  bool isPlaying = false;

  @override
  void initState() {
    super.initState();
    _initializePlayer();
  }

  Future<void> _initializePlayer() async {
    _audioPlayer = AudioPlayer();
    await _audioPlayer.setReleaseMode(ReleaseMode.loop);
    _playMusic();
  }

  Future<void> _playMusic() async {
    try {
      var manifest = await _yt.videos.streamsClient.getManifest(widget.videoId);
      var audioStream = manifest.audioOnly.withHighestBitrate();

      await _audioPlayer.play(UrlSource(audioStream.url.toString()));
      setState(() => isPlaying = true);
    } catch (e) {
      print("Error: $e");
    }
  }

  void _togglePlayPause() async {
    if (isPlaying) {
      await _audioPlayer.pause();
    } else {
      await _audioPlayer.resume();
    }
    setState(() => isPlaying = !isPlaying);
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    _yt.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.network(widget.thumbnailUrl, width: 200),
          const SizedBox(height: 20),
          Text(widget.title,
              style:
                  const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          Text(widget.channelName,
              style: const TextStyle(fontSize: 16, color: Colors.grey)),
          const SizedBox(height: 20),
          IconButton(
            icon: Icon(
                isPlaying
                    ? Icons.pause_circle_filled
                    : Icons.play_circle_filled,
                size: 64),
            onPressed: _togglePlayPause,
          ),
        ],
      ),
    );
  }
}
