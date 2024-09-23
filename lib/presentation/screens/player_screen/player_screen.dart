import 'dart:async';
import 'dart:ui';
import 'package:audio_service/audio_service.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:musiq/core/colors.dart';
import 'package:musiq/core/sized.dart';
import 'package:musiq/data/add_to_library_funtions.dart';
import 'package:musiq/main.dart';
import 'package:musiq/models/song_model.dart';
import 'package:musiq/presentation/commanWidgets/custom_app_bar.dart';
import 'package:musiq/presentation/commanWidgets/favorite_icon.dart';
import 'package:musiq/presentation/screens/player_screen/cubit/PlayAndPause/play_and_pause_cubit.dart';
import 'package:musiq/presentation/screens/player_screen/cubit/ProgressBar/progress_bar_cubit.dart';
import 'package:musiq/presentation/screens/player_screen/widgets/progress_bar_widget.dart';

class PlayerScreen extends StatefulWidget {
  final List<SongModel> songs;
  final int initialIndex;

  const PlayerScreen({super.key, required this.songs, this.initialIndex = 0});

  @override
  State<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  late int _currentIndex;
  late ScrollController _scrollController;
  late StreamSubscription<PlaybackState> _playbackStateSubscription;

  bool hasPlayed = false;

  SongModel get currentSong => widget.songs[_currentIndex];

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _scrollController = ScrollController();
    _initializeAudioHandler();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToCurrentSong();
    });
  }

  Future<void> _initializeAudioHandler() async {
    _playbackStateSubscription =
        audioHandler.playbackState.listen((playbackState) {
      final isPlaying = playbackState.playing;
      final position = playbackState.updatePosition;
      final processingState = playbackState.processingState;

      context.read<PlayAndPauseCubit>().togglePlayerState(isPlaying);
      context.read<ProgressBarCubit>().changeProgress(position);

      if (processingState == AudioProcessingState.completed) {
        _playNext();
      }
    });

    _playSong(widget.songs[_currentIndex]);
  }

  void _playSong(SongModel song) async {
    AddToLibrary.addToLastPlayedSong(song);
    await audioHandler.stop();
    await audioHandler.playUrl(song.url);
    await audioHandler.playMediaItem(
    
      MediaItem(
        id: song.url,
        album: song.album,
        title: song.title,
        displayTitle: song.title,
        duration: Duration(seconds: song.duration),
        artist: song.subtitle,
        artUri: Uri.parse(song.url),
      ),
    );

    await audioHandler.play();
  }

  void _playNext() async {
    if (_currentIndex < widget.songs.length - 1) {
      await audioHandler.playNext();
      setState(() {
        _currentIndex++;
      });
      _playSong(widget.songs[_currentIndex]);

      _scrollToCurrentSong();
    }
  }

  void _playPrevious() async {
    if (_currentIndex > 0) {
      await audioHandler.playPrevious();
      setState(() {
        _currentIndex--;
      });
      _playSong(widget.songs[_currentIndex]);

      _scrollToCurrentSong();
    }
  }

  void _scrollToCurrentSong() {
    if (_scrollController.hasClients) {
      const double itemHeight = 50;
      final double scrollPosition =
          (_currentIndex * itemHeight) - (itemHeight * 1.5);

      _scrollController.animateTo(
        scrollPosition,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  void dispose() {
    _playbackStateSubscription.cancel();
    // audioHandler.stop();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    final theme = Theme.of(context);

    double imageSize = isMobile(context)
        ? screenWidth * 0.7
        : (isTablet(context) ? screenWidth * 0.6 : screenWidth * 0.2);
    double fontSize = isMobile(context)
        ? screenWidth * 0.15
        : (isTablet(context) ? screenWidth * 0.08 : screenWidth * 0.03);
    double sidebarWidth = isDesktop(context) ? screenWidth * 0.45 : 0;

    return Scaffold(
      body: SafeArea(
        child: Row(
          children: [
            Expanded(
              flex: 4,
              child: Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: CachedNetworkImageProvider(currentSong.imageUrl),
                    alignment: isMobile(context)
                        ? const Alignment(1, -2)
                        : const Alignment(1, 20),
                    fit: BoxFit.fitWidth,
                  ),
                ),
                child: GestureDetector(
                  onHorizontalDragEnd: (DragEndDetails details) {
                    if (details.primaryVelocity! < 0) {
                      _playNext();
                    } else if (details.primaryVelocity! > 0) {
                      _playPrevious();
                    }
                  },
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 100, sigmaY: 100),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: isMobile(context) ? 10 : 100),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            CustomAppBar(title: currentSong.album),
                            constHeight30,
                            Container(
                              height: screenHeight * 0.3,
                              width: imageSize,
                              margin:
                                  EdgeInsets.all(isMobile(context) ? 20 : 100),
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: CachedNetworkImageProvider(
                                      currentSong.imageUrl),
                                  fit: BoxFit.fill,
                                ),
                                borderRadius: BorderRadius.circular(
                                    isMobile(context) ? 15 : 20),
                              ),
                            ),
                            SizedBox(height: isMobile(context) ? 50 : 20),
                            Text(
                              currentSong.title,
                              style: TextStyle(
                                fontSize: isMobile(context) ? 35 : 50,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.fade,
                              softWrap: false,
                            ),
                            SizedBox(height: isMobile(context) ? 15 : 10),
                            Text(
                              currentSong.subtitle,
                              maxLines: 1,
                              overflow: TextOverflow.fade,
                              softWrap: false,
                            ),
                            SizedBox(height: isMobile(context) ? 35 : 30),
                            BlocBuilder<ProgressBarCubit, ProgressBarState>(
                              builder: (context, state) {
                                if (state is ProgressBarInitial) {
                                  return ProgressBarWidget(
                                    song: widget.songs[_currentIndex],
                                    audioPlayer: audioHandler,
                                    progressDuration: state.progressDuration,
                                  );
                                }
                                return ProgressBarWidget(
                                  song: widget.songs[_currentIndex],
                                  audioPlayer: audioHandler,
                                  progressDuration: Duration.zero,
                                );
                              },
                            ),
                            SizedBox(height: isMobile(context) ? 15 : 20),
                            Row(
                              children: [
                                FavoriteIcon(song: currentSong),
                                const Spacer(),
                                IconButton(
                                  onPressed: _playPrevious,
                                  icon: Icon(
                                    Icons.skip_previous_rounded,
                                    size: fontSize,
                                    color: _currentIndex == 0
                                        ? const Color.fromARGB(
                                            99, 158, 158, 158)
                                        : null,
                                  ),
                                ),
                                BlocBuilder<PlayAndPauseCubit,
                                    PlayAndPauseState>(
                                  builder: (context, state) {
                                    if (state is PlayingState) {
                                      return IconButton(
                                        onPressed: () {
                                          audioHandler.play();
                                        },
                                        icon: Icon(
                                          Icons.play_circle_fill_rounded,
                                          size: fontSize * 1.2,
                                        ),
                                      );
                                    }
                                    if (state is PausedState) {
                                      return IconButton(
                                        onPressed: () {
                                          audioHandler.pause();
                                        },
                                        icon: Icon(
                                          Icons.pause_circle_filled,
                                          size: fontSize * 1.2,
                                        ),
                                      );
                                    }
                                    return SizedBox(
                                      height: fontSize,
                                      width: fontSize,
                                      child: Theme.of(context).brightness ==
                                              Brightness.dark
                                          ? Lottie.asset(
                                              "assets/animations/light_music_loading.json",
                                              fit: BoxFit.cover)
                                          : Lottie.asset(
                                              "assets/animations/dark_music_loading.json",
                                            ),
                                    );
                                  },
                                ),
                                IconButton(
                                  onPressed: _playNext,
                                  icon: Icon(Icons.skip_next_rounded,
                                      size: fontSize,
                                      color: _currentIndex ==
                                              ((widget.songs.length) - 1)
                                          ? const Color.fromARGB(
                                              99, 158, 158, 158)
                                          : null),
                                ),
                                const Spacer(),
                                IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.download,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                if (isMobile(context))
                                  IconButton(
                                    onPressed: () {
                                      showModalBottomSheet(
                                        backgroundColor:
                                            theme.brightness == Brightness.dark
                                                ? Colors.black.withOpacity(0.7)
                                                : Colors.white.withOpacity(0.7),
                                        context: context,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        builder: (BuildContext context) {
                                          return Padding(
                                              padding: EdgeInsets.all(10),
                                              child: _buildSongList(context));
                                        },
                                      );
                                    },
                                    icon: const Icon(Icons.queue_music_sharp),
                                  ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            if (isDesktop(context))
              Container(
                width: sidebarWidth,
                color: Colors.transparent,
                child: _buildSongList(context),
              )
          ],
        ),
      ),
    );
  }

  Widget _buildSongList(BuildContext context) {
    return ReorderableListView(
      onReorder: (oldIndex, newIndex) {
        setState(() {
          if (newIndex > oldIndex) {
            newIndex -= 1;
          }
          final moveSong = widget.songs.removeAt(oldIndex);
          widget.songs.insert(newIndex, moveSong);
          if (_currentIndex == oldIndex) {
            _currentIndex = newIndex;
          } else if (_currentIndex > oldIndex && _currentIndex <= newIndex) {
            _currentIndex--;
          } else if (_currentIndex < oldIndex && _currentIndex >= newIndex) {
            _currentIndex++;
          }
        });
      },
      children: List.generate(widget.songs.length, (index) {
        return ListTile(
          key: ValueKey(widget.songs[index].id),
          onTap: () {
            if (index != _currentIndex) {
              audioHandler.stop();
              setState(() {
                _currentIndex = index;
                hasPlayed = false;
              });
              // _initializePlayer();
              _initializeAudioHandler();
              _scrollToCurrentSong();
            }
          },
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _currentIndex == index
                  ? Lottie.asset(
                      Theme.of(context).brightness == Brightness.dark
                          ? "assets/animations/musicPlaying_light.json"
                          : "assets/animations/musicPlaying_dark.json",
                      height: 50,
                      width: 50)
                  : const SizedBox(),
              FavoriteIcon(
                song: widget.songs[index],
              ),
            ],
          ),
          leading: Container(
            width: 60,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: CachedNetworkImageProvider(
                  widget.songs[index].imageUrl,
                ),
                fit: BoxFit.fill,
              ),
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          title: Text(
            widget.songs[index].title,
            maxLines: 1,
            style: TextStyle(
                color: _currentIndex == index ? colorList[colorIndex] : null),
          ),
          subtitle: Text(
            widget.songs[index].subtitle,
            maxLines: 1,
            style: TextStyle(
                color: _currentIndex == index ? colorList[colorIndex] : null),
          ),
        );
      }),
    );
  }
}
