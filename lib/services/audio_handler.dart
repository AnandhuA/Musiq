import 'dart:developer';

import 'package:audio_service/audio_service.dart';
import 'package:audioplayers/audioplayers.dart';

class AudioPlayerHandler extends BaseAudioHandler with SeekHandler {
  final AudioPlayer _player;
  List<MediaItem> _mediaItems = [];
  int _currentIndex = 0;

  AudioPlayerHandler() : _player = AudioPlayer() {
    _initializePlayer();
  }

  Future<void> _initializePlayer() async {
    _player.onPlayerStateChanged.listen((state) {
      playbackState.add(playbackStateForPlayer(state));
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
  }

  Future<void> _onSongComplete() async {
    if (_currentIndex < _mediaItems.length - 1) {
      _currentIndex++;
      await _playCurrentSong();
    } else {
      await stop();
      playbackState.add(playbackStateForPlayer(
        _player.state,
        processingState: AudioProcessingState.completed,
      ));
    }
  }

  Future<void> playUrl(String url) async {
    await _player.setSourceUrl(url);
    await play();
  }

  @override
  Future<void> play() async {
    await _player.resume();
    // await _playCurrentSong();
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

  Future<void> setMediaItems(List<MediaItem> mediaItems) async {
    _mediaItems = mediaItems;
  }

  Future<void> playNext() async {
    log("next");
    if (_currentIndex < _mediaItems.length - 1) {
      _currentIndex++;
      await _playCurrentSong();
    }
  }

  Future<void> playPrevious() async {
    log("pre");
    if (_currentIndex > 0) {
      _currentIndex--;
      await _playCurrentSong();
    }
  }

  Future<void> _playCurrentSong() async {
    final currentMediaItem = _mediaItems[_currentIndex];
    log("${currentMediaItem.id}");
    await playUrl(currentMediaItem.id);
    mediaItem.add(currentMediaItem);
  }
}


PlaybackState playbackStateForPlayer(PlayerState state,
    {Duration updatePosition = Duration.zero,
    AudioProcessingState processingState = AudioProcessingState.ready}) {
  return PlaybackState(
    controls: _getControlsForState(state),
    processingState: processingState,
    playing: state == PlayerState.playing,
    updatePosition: updatePosition,
  );
}

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
      MediaControl.skipToNext,
      MediaControl.skipToPrevious,
    ];
  }
}

AudioProcessingState mapProcessingState(PlayerState state) {
  switch (state) {
    case PlayerState.playing:
      return AudioProcessingState.ready;
    case PlayerState.paused:
      return AudioProcessingState.ready;
    case PlayerState.stopped:
      return AudioProcessingState.idle;
    default:
      return AudioProcessingState.completed;
  }
}
