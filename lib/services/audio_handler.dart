import 'package:audio_service/audio_service.dart';
import 'package:just_audio/just_audio.dart';
import 'package:musiq/core/helper_funtions.dart';
import 'package:musiq/data/hive_funtion.dart';
import 'package:musiq/main.dart';
import 'package:musiq/models/song_model/song.dart';
import 'package:musiq/presentation/screens/player_screen/player_screen.dart';

class AudioPlayerHandler extends BaseAudioHandler with SeekHandler {
  final AudioPlayer _player;
  List<MediaItem> _mediaItems = [];
  List<Song> _songList = [];
  bool _isShuffled = false;

  AudioPlayerHandler() : _player = AudioPlayer() {
    _initializePlayer();
  }

  Future<void> _initializePlayer() async {
    _player.playerStateStream.listen((state) {
      _handlePlayerStateChange(state);
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

  void _handlePlayerStateChange(PlayerState state) {
    playbackState.add(playbackStateForPlayer(state));

    if (state.processingState == ProcessingState.completed) {
      skipToNext();
    }
  }

  Future<void> _playUrl(String url) async {
    await _player.setUrl(url);
    await play();
  }

  void toggleShuffle() {
    _isShuffled = !_isShuffled;
  }
    bool isShuffleOn() {
    return _isShuffled;
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
    if (_isShuffled) {
      currentSongIndex = getRandomSongIndex(songList: _mediaItems);
      lastplayedSongNotifier.value = _songList;
      await playCurrentSong();
    } else if (currentSongIndex < _mediaItems.length - 1) {
      currentSongIndex++;
      lastplayedSongNotifier.value = _songList;
      await playCurrentSong();
    }
  }

  @override
  Future<void> skipToPrevious() async {
    if (currentSongIndex > 0) {
      currentSongIndex--;

      await playCurrentSong();
    }
  }

  

  Future<void> playCurrentSong() async {
    if (_mediaItems.isNotEmpty) {
      final newMediaItem = _mediaItems[currentSongIndex];
      mediaItem.add(newMediaItem);
      LastPlayedRepo.addToLastPlayedSong(_songList[currentSongIndex]);
      lastplayedSongNotifier.value = _songList;
      await _playUrl(newMediaItem.id);
    }
  }

  void setMediaItems({
    required List<MediaItem> mediaItems,
    required int currentIndex,
    required List<Song> songList,
  }) {
    _mediaItems = mediaItems;
    currentSongIndex = currentIndex;
    _songList = songList;
  }
}

// Playback state for player
PlaybackState playbackStateForPlayer(
  PlayerState state, {
  Duration updatePosition = Duration.zero,
}) {
  final audioProcessingState = _mapProcessingState(state.processingState);

  return PlaybackState(
    controls: _getControlsForState(state),
    processingState: audioProcessingState,
    playing: state.playing,
    updatePosition: updatePosition,
  );
}

AudioProcessingState _mapProcessingState(ProcessingState state) {
  switch (state) {
    case ProcessingState.completed:
      return AudioProcessingState.completed;
    case ProcessingState.buffering:
      return AudioProcessingState.buffering;
    case ProcessingState.loading:
      return AudioProcessingState.loading;
    case ProcessingState.idle:
      return AudioProcessingState.idle;
    case ProcessingState.ready:
      return AudioProcessingState.ready;
    default:
      return AudioProcessingState.error;
  }
}

// Define media controls based on player state
List<MediaControl> _getControlsForState(PlayerState state) {
  return state.playing
      ? [
          MediaControl.pause,
          MediaControl.skipToNext,
          MediaControl.skipToPrevious,
        ]
      : [MediaControl.play];
}
