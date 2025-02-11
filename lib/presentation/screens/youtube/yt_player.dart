import 'dart:developer';
import 'dart:io'; // Add this to check platform
import 'package:flutter/material.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import 'package:video_player/video_player.dart';
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
  VideoPlayerController? _videoPlayerController;
  late AudioPlayer _audioPlayer;
  bool isPlaying = false;

  @override
  void initState() {
    super.initState();
    _initializePlayer();
  }

  // Initialize video and audio players
  Future<void> _initializePlayer() async {
    _audioPlayer = AudioPlayer();
    try {
      // Fetch video data from YouTube
      var video = await _yt.videos.get(widget.videoId);
      var manifest = await _yt.videos.streamsClient.getManifest(widget.videoId);

      // Set up video player for mobile/web (not supported on Windows)
      if (!Platform.isWindows) {
        var videoStream = video.url;
        _videoPlayerController =
            VideoPlayerController.networkUrl(Uri.parse(videoStream))
              ..initialize().then((_) {
                setState(() {});
              });
      }

      // Set up audio player
      var audioStream = manifest.audioOnly.withHighestBitrate();
      await _audioPlayer.setReleaseMode(ReleaseMode.loop);
      await _audioPlayer.play(UrlSource(audioStream.url.toString()));
    } catch (e) {
      log("Error initializing players: $e");
    }
  }

  // Toggle play/pause for video and audio
  void _togglePlayPause() async {
    if (_videoPlayerController != null &&
        _videoPlayerController!.value.isPlaying) {
      await _videoPlayerController!.pause();
      await _audioPlayer.pause();
    } else {
      await _videoPlayerController?.play();
      await _audioPlayer.resume();
    }
    setState(() {
      isPlaying = !isPlaying;
    });
  }

  @override
  void dispose() {
    _videoPlayerController?.dispose();
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
          // Video Player (only for mobile/web, not for Windows)
          if (_videoPlayerController != null &&
              _videoPlayerController!.value.isInitialized &&
              !Platform.isWindows)
            AspectRatio(
              aspectRatio: _videoPlayerController!.value.aspectRatio,
              child: VideoPlayer(_videoPlayerController!),
            ),
          const SizedBox(height: 20),
          // Song title and channel name
          Text(widget.title,
              style:
                  const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          Text(widget.channelName,
              style: const TextStyle(fontSize: 16, color: Colors.grey)),
          const SizedBox(height: 20),
          // Play/Pause Button
          IconButton(
            icon: Icon(
              isPlaying ? Icons.pause_circle_filled : Icons.play_circle_filled,
              size: 64,
            ),
            onPressed: _togglePlayPause,
          ),
        ],
      ),
    );
  }
}
