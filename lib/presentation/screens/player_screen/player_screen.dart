import 'dart:async';
import 'dart:ui';
import 'package:audio_service/audio_service.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:musiq/core/colors.dart';
import 'package:musiq/core/sized.dart';
import 'package:musiq/data/hive_funtion.dart';
import 'package:musiq/data/shared_preference.dart';
import 'package:musiq/main.dart';
import 'package:musiq/models/song_model.dart';
import 'package:musiq/presentation/commanWidgets/custom_app_bar.dart';
import 'package:musiq/presentation/commanWidgets/favorite_icon.dart';
import 'package:musiq/presentation/screens/player_screen/cubit/PlayAndPause/play_and_pause_cubit.dart';
import 'package:musiq/presentation/screens/player_screen/cubit/ProgressBar/progress_bar_cubit.dart';
import 'package:musiq/presentation/screens/player_screen/widgets/progress_bar_widget.dart';

int currentSongIndex = 0;

class PlayerScreen extends StatefulWidget {
  final List<SongModel> songs;
  final int initialIndex;

  const PlayerScreen({super.key, required this.songs, this.initialIndex = 0});

  @override
  State<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  late ScrollController _scrollController;
  late StreamSubscription<PlaybackState> _playbackStateSubscription;
  bool _loading = false;
  bool hasPlayed = false;

  SongModel get currentSong => widget.songs[currentSongIndex];

  @override
  void initState() {
    super.initState();
    currentSongIndex = widget.initialIndex;
    _scrollController = ScrollController();
    _initializeAudioHandler();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToCurrentSong();
    });
  }

  Future<void> _initializeAudioHandler() async {
    audioHandler.setMediaItems(
        mediaItems: widget.songs
            .map((song) => MediaItem(
                  id: song.url,
                  album: song.album,
                  title: song.title,
                  displayTitle: song.title,
                  duration: Duration(seconds: song.duration),
                  artist: song.subtitle,
                  artUri: Uri.parse(song.imageUrl),
                ))
            .toList(),
        currentIndex: currentSongIndex);
    _playbackStateSubscription =
        audioHandler.playbackState.listen((playbackState) {
      final isPlaying = playbackState.playing;
      final position = playbackState.updatePosition;
      final processingState = playbackState.processingState;

      context.read<PlayAndPauseCubit>().togglePlayerState(isPlaying);
      context.read<ProgressBarCubit>().changeProgress(position);

      if (processingState == AudioProcessingState.completed) {
        setState(() {});
        LastPlayedRepo.addToLastPlayedSong(widget.songs[currentSongIndex]);
        lastplayed = widget.songs[currentSongIndex];
        SharedPreference.addLastPlayedSong(widget.songs[currentSongIndex]);
      }
    });

    _playSong(widget.songs[currentSongIndex]);
  }

  void _playSong(SongModel song) async {
    setState(() {
      _loading = true;
    });
    LastPlayedRepo.addToLastPlayedSong(song);
    lastplayed = widget.songs[currentSongIndex];
    SharedPreference.addLastPlayedSong(widget.songs[currentSongIndex]);
    await audioHandler.stop();
    await audioHandler.playCurrentSong();
    await audioHandler.play();
    setState(() {
      _loading = false;
    });
  }

  void _playNext() async {
    if (currentSongIndex < widget.songs.length - 1) {
      setState(() {
        _loading = true;
      });
      await audioHandler.skipToNext();

      _scrollToCurrentSong();
      setState(() {
        _loading = false;
      });
    }
  }

  void _playPrevious() async {
    if (currentSongIndex > 0) {
      setState(() {
        _loading = true;
      });
      await audioHandler.skipToPrevious();

      _scrollToCurrentSong();
      setState(() {
        _loading = false;
      });
    }
  }

  void _scrollToCurrentSong() {
    if (_scrollController.hasClients) {
      const double itemHeight = 50;
      final double scrollPosition =
          (currentSongIndex * itemHeight) - (itemHeight * 1.5);

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
                                    song: widget.songs[currentSongIndex],
                                    audioPlayer: audioHandler,
                                    progressDuration: state.progressDuration,
                                  );
                                }
                                return ProgressBarWidget(
                                  song: widget.songs[currentSongIndex],
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
                                    color: currentSongIndex == 0
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
                                        icon: _loading
                                            ? Theme.of(context).brightness ==
                                                    Brightness.dark
                                                ? Lottie.asset(
                                                    "assets/animations/light_music_loading.json",
                                                    fit: BoxFit.cover,
                                                    width: fontSize,
                                                    height: fontSize,
                                                  )
                                                : Lottie.asset(
                                                    "assets/animations/dark_music_loading.json",
                                                    fit: BoxFit.cover,
                                                    width: fontSize,
                                                    height: fontSize)
                                            : Icon(
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
                                        icon: _loading
                                            ? Theme.of(context).brightness ==
                                                    Brightness.dark
                                                ? Lottie.asset(
                                                    "assets/animations/light_music_loading.json",
                                                    width: fontSize,
                                                    height: fontSize,
                                                    fit: BoxFit.cover)
                                                : Lottie.asset(
                                                    "assets/animations/dark_music_loading.json",
                                                    fit: BoxFit.cover,
                                                    width: fontSize,
                                                    height: fontSize,
                                                  )
                                            : Icon(
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
                                      color: currentSongIndex ==
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
                                  songListMobile(theme, context),
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

  IconButton songListMobile(ThemeData theme, BuildContext context) {
    return IconButton(
      onPressed: () {
        showModalBottomSheet(
          backgroundColor: theme.brightness == Brightness.dark
              ? Colors.black.withOpacity(0.7)
              : Colors.white.withOpacity(0.7),
          context: context,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          builder: (BuildContext context) {
            return StatefulBuilder(
              builder: (BuildContext context, StateSetter setModalState) {
                return Padding(
                  padding: const EdgeInsets.all(10),
                  child: ReorderableListView(
                    onReorder: (oldIndex, newIndex) {
                      setModalState(() {
                        if (newIndex > oldIndex) {
                          newIndex -= 1;
                        }
                        final moveSong = widget.songs.removeAt(oldIndex);
                        widget.songs.insert(newIndex, moveSong);
                        if (currentSongIndex == oldIndex) {
                          currentSongIndex = newIndex;
                        } else if (currentSongIndex > oldIndex &&
                            currentSongIndex <= newIndex) {
                          currentSongIndex--;
                        } else if (currentSongIndex < oldIndex &&
                            currentSongIndex >= newIndex) {
                          currentSongIndex++;
                        }
                        audioHandler.setMediaItems(
                          mediaItems: widget.songs
                              .map((song) => MediaItem(
                                    id: song.url,
                                    album: song.album,
                                    title: song.title,
                                    displayTitle: song.title,
                                    duration: Duration(seconds: song.duration),
                                    artist: song.subtitle,
                                    artUri: Uri.parse(song.imageUrl),
                                  ))
                              .toList(),
                          currentIndex: currentSongIndex,
                        );
                      });
                    },
                    children: List.generate(widget.songs.length, (index) {
                      return ListTile(
                        key: ValueKey(widget.songs[index].id),
                        onTap: () {
                          if (index != currentSongIndex) {
                            audioHandler.stop();
                            setState(() {
                              currentSongIndex = index;
                              hasPlayed = false;
                            });
                            // Reinitialize player
                            _initializeAudioHandler();
                            _scrollToCurrentSong();
                          }
                        },
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            currentSongIndex == index
                                ? Lottie.asset(
                                    Theme.of(context).brightness ==
                                            Brightness.dark
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
                              color: currentSongIndex == index
                                  ? colorList[colorIndex]
                                  : null),
                        ),
                        subtitle: Text(
                          widget.songs[index].subtitle,
                          maxLines: 1,
                          style: TextStyle(
                              color: currentSongIndex == index
                                  ? colorList[colorIndex]
                                  : null),
                        ),
                      );
                    }),
                  ),
                );
              },
            );
          },
        );
      },
      icon: const Icon(Icons.queue_music_sharp),
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
          if (currentSongIndex == oldIndex) {
            currentSongIndex = newIndex;
          } else if (currentSongIndex > oldIndex &&
              currentSongIndex <= newIndex) {
            currentSongIndex--;
          } else if (currentSongIndex < oldIndex &&
              currentSongIndex >= newIndex) {
            currentSongIndex++;
          }
          audioHandler.setMediaItems(
            mediaItems: widget.songs
                .map((song) => MediaItem(
                      id: song.url,
                      album: song.album,
                      title: song.title,
                      displayTitle: song.title,
                      duration: Duration(seconds: song.duration),
                      artist: song.subtitle,
                      artUri: Uri.parse(song.imageUrl),
                    ))
                .toList(),
            currentIndex: currentSongIndex,
          );
        });
      },
      children: List.generate(widget.songs.length, (index) {
        return ListTile(
          key: ValueKey(widget.songs[index].id),
          onTap: () {
            if (index != currentSongIndex) {
              audioHandler.stop();
              setState(() {
                currentSongIndex = index;
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
              currentSongIndex == index
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
                color:
                    currentSongIndex == index ? colorList[colorIndex] : null),
          ),
          subtitle: Text(
            widget.songs[index].subtitle,
            maxLines: 1,
            style: TextStyle(
                color:
                    currentSongIndex == index ? colorList[colorIndex] : null),
          ),
        );
      }),
    );
  }
}
