import 'dart:developer';

import 'package:audio_service/audio_service.dart';
import 'package:audioplayers/audioplayers.dart';

class AudioPlayerHandler extends BaseAudioHandler with SeekHandler {
  final AudioPlayer _player;

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
    playbackState.add(playbackStateForPlayer(
      _player.state,
      processingState: AudioProcessingState.completed,
    ));
  }

  Future<void> _playUrl(String url) async {
    log("url ply");
    await _player.setSourceUrl(url);
    await play();
  }

  @override
  Future<void> play() async {
    log("play");
    await _player.resume();
  }

  @override
  Future<void> pause() async {
    log("pause");
    await _player.pause();
  }

  @override
  Future<void> seek(Duration position) async {
    await _player.seek(position);
  }

  @override
  Future<void> stop() async {
    log("stop");
    await _player.stop();
  }

  Future<void> playNext({required MediaItem newMediaItem}) async {
    log("next");
    await playCurrentSong(newMediaItem: newMediaItem);
  }

  Future<void> playPrevious({required MediaItem newMediaItem}) async {
    log("pre");
    await playCurrentSong(newMediaItem: newMediaItem);
  }

  Future<void> playCurrentSong({required MediaItem newMediaItem}) async {
    mediaItem.add(newMediaItem);
    await _playUrl(newMediaItem.id);
    playbackState.add(playbackStateForPlayer(_player.state));
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

AudioProcessingState mapProcessingState(PlayerState state) {
  switch (state) {
    case PlayerState.playing:
      return AudioProcessingState.ready;
    case PlayerState.paused:
      return AudioProcessingState.ready;
    case PlayerState.stopped:
      return AudioProcessingState.idle;
    case PlayerState.completed:
      return AudioProcessingState.completed;
    default:
      return AudioProcessingState.buffering;
  }
}
