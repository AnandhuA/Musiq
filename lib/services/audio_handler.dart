import 'dart:developer';
import 'package:audio_service/audio_service.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:musiq/presentation/screens/player_screen/player_screen.dart';

class AudioPlayerHandler extends BaseAudioHandler with SeekHandler {
  final AudioPlayer _player;
  List<MediaItem> _mediaItems = [];
  bool _pausedByFocusLoss = false;

  AudioPlayerHandler() : _player = AudioPlayer() {
    _initializePlayer();
  }

  Future<void> _initializePlayer() async {
    _player.onPlayerStateChanged.listen((state) {
      playbackState.add(playbackStateForPlayer(state));

      if (_pausedByFocusLoss && state == PlayerState.playing) {
        log("Playback resumed after focus loss, pausing again.");
        _player.pause();
      }
    });

    _player.onPositionChanged.listen((position) {
      playbackState.add(
        playbackStateForPlayer(
          _player.state,
          updatePosition: position,
        ),
      );
    });

    _player.onPlayerComplete.listen((_) {
      _onSongComplete();
    });

    _player.onPlayerStateChanged.listen((state) {
      if (state == PlayerState.paused) {
        log("Audio focus lost, pausing the player.");
        _pausedByFocusLoss = true;
        playbackState.add(playbackStateForPlayer(PlayerState.paused));
      } else if (state == PlayerState.playing) {
        log("Audio focus gained.");
        _pausedByFocusLoss = false;
      }
    });
  }

  Future<void> _onSongComplete() async {
    playbackState.add(playbackStateForPlayer(
      _player.state,
      processingState: AudioProcessingState.completed,
    ));
    await skipToNext();
  }

  Future<void> _playUrl(String url) async {
    await _player.setSourceUrl(url);
    await play();
  }

  @override
  Future<void> play() async {
    await _player.resume();
    _pausedByFocusLoss = false;
  }

  @override
  Future<void> pause() async {
    await _player.pause();
    _pausedByFocusLoss = false;
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
      playbackState.add(playbackStateForPlayer(
        _player.state,
        processingState: AudioProcessingState.completed,
      ));
      log("Skip to next: $currentSongIndex");
      await playCurrentSong();
    }
  }

  @override
  Future<void> skipToPrevious() async {
    if (currentSongIndex > 0) {
      currentSongIndex--;
      playbackState.add(playbackStateForPlayer(
        _player.state,
        processingState: AudioProcessingState.completed,
      ));
      log("Skip to previous: $currentSongIndex");
      await playCurrentSong();
    }
  }

  Future<void> playCurrentSong() async {
    if (_mediaItems.isNotEmpty) {
      final newMediaItem = _mediaItems[currentSongIndex];
      mediaItem.add(newMediaItem);
      await _playUrl(newMediaItem.id);
      playbackState.add(playbackStateForPlayer(_player.state));
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

PlaybackState playbackStateForPlayer(
  PlayerState state, {
  Duration updatePosition = Duration.zero,
  AudioProcessingState processingState = AudioProcessingState.ready,
}) {
  return PlaybackState(
    controls: _getControlsForState(state),
    processingState: processingState,
    playing: state == PlayerState.playing,
    updatePosition: updatePosition,
  );
}

// Define media controls based on player state
List<MediaControl> _getControlsForState(PlayerState state) {
  if (state == PlayerState.playing) {
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
