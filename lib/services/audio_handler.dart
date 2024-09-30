import 'dart:developer';
import 'package:audio_service/audio_service.dart';
import 'package:just_audio/just_audio.dart';
import 'package:musiq/presentation/screens/player_screen/player_screen.dart'; 

class AudioPlayerHandler extends BaseAudioHandler with SeekHandler {
  final AudioPlayer _player;
  List<MediaItem> _mediaItems = [];

  AudioPlayerHandler() : _player = AudioPlayer() {
    _initializePlayer();
  }

  Future<void> _initializePlayer() async {
 
    _player.playerStateStream.listen((state) {
      playbackState.add(playbackStateForPlayer(state));
      log("Player state changed: ${state.playing ? 'Playing' : 'Paused'}");

      if (state.processingState == ProcessingState.completed) {
        log("Audio completed");
        _onSongComplete();
      }
    });

  
    _player.positionStream.listen((position) {
      playbackState.add(
        playbackStateForPlayer(
          _player.playerState,
          updatePosition: position,
        ),
      );
    });
  }

  Future<void> _onSongComplete() async {
    await skipToNext(); 
  }

  Future<void> _playUrl(String url) async {
    await _player.setUrl(url);
    await play();
  }

  @override
  Future<void> play() async {
    await _player.play();
  }

  @override
  Future<void> pause() async {
    await _player.pause();
  }

  @override
  Future<void> seek(Duration position) async {
    await _player.seek(position);
  }

  @override
  Future<void> stop() async {
    await _player.stop();
  }

  @override
  Future<void> skipToNext() async {
    if (currentSongIndex < _mediaItems.length - 1) {
      currentSongIndex++;
      log("Skip to next: $currentSongIndex");
      await playCurrentSong();
    }
  }

  @override
  Future<void> skipToPrevious() async {
    if (currentSongIndex > 0) {
      currentSongIndex--;
      log("Skip to previous: $currentSongIndex");
      await playCurrentSong();
    }
  }

  Future<void> playCurrentSong() async {
    if (_mediaItems.isNotEmpty) {
      final newMediaItem = _mediaItems[currentSongIndex];
      mediaItem.add(newMediaItem);
      await _playUrl(newMediaItem.id);
    }
  }

  void setMediaItems({
    required List<MediaItem> mediaItems,
    required int currentIndex,
  }) {
    _mediaItems = mediaItems;
    currentSongIndex = currentIndex;
  }
}

// Playback state for player
PlaybackState playbackStateForPlayer(
  PlayerState state, {
  Duration updatePosition = Duration.zero,
  AudioProcessingState processingState = AudioProcessingState.ready,
}) {
  return PlaybackState(
    controls: _getControlsForState(state),
    processingState: processingState,
    playing: state.playing,
    updatePosition: updatePosition,
  );
}

// Define media controls based on player state
List<MediaControl> _getControlsForState(PlayerState state) {
  if (state.playing) {
    return [
      MediaControl.pause,
      MediaControl.skipToNext,
      MediaControl.skipToPrevious,
    ];
  } else {
    return [
      MediaControl.play,
    ];
  }
}
