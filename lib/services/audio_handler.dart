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
  }

  Future<void> playUrl(String url) async {
    await _player.setSourceUrl(url);
    await play();
  }

  @override
  Future<void> play() async {
    await _player.resume();
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
    if (_currentIndex < _mediaItems.length - 1) {
      _currentIndex++;
      await _playCurrentSong();
    }
  }

  Future<void> playPrevious() async {
    if (_currentIndex > 0) {
      _currentIndex--;
      await _playCurrentSong();
    }
  }

  Future<void> _playCurrentSong() async {
    final currentMediaItem = _mediaItems[_currentIndex];
    await playUrl(currentMediaItem.id); // Use the URL of the media item
    // await audioService.setMediaItem(currentMediaItem); // Update media item
  }
}

PlaybackState playbackStateForPlayer(PlayerState state,
    {Duration updatePosition = Duration.zero}) {
  return PlaybackState(
    controls: _getControlsForState(state),
    processingState: _mapProcessingState(state),
    playing: state == PlayerState.playing,
    updatePosition: updatePosition,
  );
}

List<MediaControl> _getControlsForState(PlayerState state) {
  if (state == PlayerState.playing) {
    return [MediaControl.pause, MediaControl.stop];
  } else {
    return [MediaControl.play, MediaControl.stop];
  }
}

AudioProcessingState _mapProcessingState(PlayerState state) {
  switch (state) {
    case PlayerState.playing:
      return AudioProcessingState.ready;
    case PlayerState.paused:
      return AudioProcessingState.idle;
    case PlayerState.stopped:
    default:
      return AudioProcessingState.completed;
  }
}
