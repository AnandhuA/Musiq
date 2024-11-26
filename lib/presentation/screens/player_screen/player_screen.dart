import 'dart:async';
import 'dart:developer';
import 'dart:ui';
import 'package:audio_service/audio_service.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:musiq/bloc/FeatchSong/fetch_song_cubit.dart';
import 'package:musiq/core/colors.dart';
import 'package:musiq/core/global_variables.dart';
import 'package:musiq/core/helper_funtions.dart';
import 'package:musiq/core/sized.dart';
import 'package:musiq/data/download_song.dart';
import 'package:musiq/models/song_model/song.dart';
import 'package:musiq/presentation/commanWidgets/bottom_sheet.dart';
import 'package:musiq/presentation/commanWidgets/custom_app_bar.dart';
import 'package:musiq/presentation/commanWidgets/favorite_icon.dart';
import 'package:musiq/presentation/screens/player_screen/cubit/PlayAndPause/play_and_pause_cubit.dart';
import 'package:musiq/presentation/screens/player_screen/cubit/ProgressBar/progress_bar_cubit.dart';
import 'package:musiq/presentation/screens/player_screen/widgets/pop_up.dart';
import 'package:musiq/presentation/screens/player_screen/widgets/progress_bar_widget.dart';

class PlayerScreen extends StatefulWidget {
  final List<Song> songs;
  final int initialIndex;
  final Duration currentpostion;
  final bool shuffle;

  const PlayerScreen({
    super.key,
    required this.songs,
    this.initialIndex = 0,
    this.currentpostion = Duration.zero,
    this.shuffle = false,
  });

  @override
  State<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  late ScrollController _scrollController;
  late StreamSubscription<PlaybackState> _playbackStateSubscription;
  bool hasPlayed = false;
  late bool _shuffle;

  Song get currentSong => widget.songs[AppGlobals().currentSongIndex];

  @override
  void initState() {
    super.initState();
    _shuffle = widget.shuffle;
    if (widget.shuffle && !AppGlobals().audioHandler.isShuffleOn()) {
      AppGlobals().audioHandler.toggleShuffle();
    }
    AppGlobals().setCurrentSongIndex(widget.initialIndex);
    _scrollController = ScrollController();
    _initializeAudioHandler();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToCurrentSong();
    });
  }

  Future<void> _initializeAudioHandler({bool chage = true}) async {
    if (widget.currentpostion != Duration.zero && chage) {
      _playbackStateSubscription =
          AppGlobals().audioHandler.playbackState.listen((playbackState) {
        if (!mounted) return;
        bool isPlaying = playbackState.playing;
        Duration position = playbackState.updatePosition;
        AudioProcessingState processingState = playbackState.processingState;
        bool loading = processingState == AudioProcessingState.loading;

        context.read<PlayAndPauseCubit>().togglePlayerState(
              isPlaying: isPlaying,
              loading: loading,
            );
        context.read<ProgressBarCubit>().changeProgress(position);
        if (processingState == AudioProcessingState.completed) {
          log("player----------$processingState");
          if (mounted) {
            setState(() {});
          }
        }
      });
      return;
    }

    // Initialize if not already set
    AppGlobals().audioHandler.setMediaItems(
          mediaItems: widget.songs
              .map((song) => MediaItem(
                    id: song.downloadUrl?.last.link ?? "",
                    album: song.album?.name ?? "No ",
                    title: song.label ?? "No ",
                    displayTitle: song.name,
                    duration: Duration(seconds: song.duration ?? 0),
                    artUri:
                        Uri.parse(song.image?.last.imageUrl ?? errorImage()),
                  ))
              .toList(),
          currentIndex: AppGlobals().currentSongIndex,
          songList: widget.songs,
        );

    _playbackStateSubscription =
        AppGlobals().audioHandler.playbackState.listen((playbackState) {
      if (!mounted) return;
      bool isPlaying = playbackState.playing;
      Duration position = playbackState.updatePosition;
      AudioProcessingState processingState = playbackState.processingState;
      bool loading = processingState == AudioProcessingState.loading;

      context.read<PlayAndPauseCubit>().togglePlayerState(
            isPlaying: isPlaying,
            loading: loading,
          );
      context.read<ProgressBarCubit>().changeProgress(position);
      if (processingState == AudioProcessingState.completed) {
        log("player----------$processingState");
        if (mounted) {
          setState(() {});
        }
      }
    });

    _playSong(widget.songs[AppGlobals().currentSongIndex]);
  }

  void _playSong(Song song) async {
    await AppGlobals().audioHandler.stop();
    await AppGlobals().audioHandler.playCurrentSong();
  }

  void _playNext() async {
    if (AppGlobals().currentSongIndex < widget.songs.length - 1) {
      await AppGlobals().audioHandler.skipToNext();
      _scrollToCurrentSong();
      setState(() {});
    }
  }

  void _playPrevious() async {
    if (AppGlobals().currentSongIndex > 0) {
      await AppGlobals().audioHandler.skipToPrevious();
      _scrollToCurrentSong();
      setState(() {});
    }
  }

  void _toggleShuffle() {
    setState(() {
      _shuffle = !_shuffle;
    });
    AppGlobals().audioHandler.toggleShuffle();
  }

  void _scrollToCurrentSong() {
    if (_scrollController.hasClients) {
      const double itemHeight = 50;
      final double scrollPosition =
          (AppGlobals().currentSongIndex * itemHeight) - (itemHeight * 1.5);

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
                    image: CachedNetworkImageProvider(
                        currentSong.image?.first.imageUrl ?? errorImage()),
                    alignment: isMobile(context)
                        ? const Alignment(1, -2)
                        : const Alignment(1, 20),
                    fit: BoxFit.fitWidth,
                  ),
                ),
                child: GestureDetector(
                  // onHorizontalDragEnd: (DragEndDetails details) {
                  //   if (details.primaryVelocity! < 0) {
                  //     _playNext();
                  //   } else if (details.primaryVelocity! > 0) {
                  //     _playPrevious();
                  //   }
                  // },
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 100, sigmaY: 100),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: isMobile(context) ? 10 : 50),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            CustomAppBar(
                              title: currentSong.album?.name ?? "NO",
                              actionButton: PopupMenuButton<int>(
                                  icon: Icon(Icons.more_vert_sharp),
                                  onSelected: (value) {
                                    switch (value) {
                                      case 0:
                                        context
                                            .read<FetchSongCubit>()
                                            .fetchAlbum(
                                                id: currentSong.album?.id ?? "",
                                                imageUrl: currentSong
                                                        .image?.last.imageUrl ??
                                                    errorImage());
                                        break;
                                      case 1:
                                        popUpWiget(
                                          context: context,
                                          list: currentSong.artists?.all ?? [],
                                        );
                                        break;
                                      case 2:
                                        showPlaylistSelectionBottomSheet(
                                          context: context,
                                          song: currentSong,
                                        );
                                        break;
                                    }
                                  },
                                  itemBuilder: (context) => [
                                        PopupMenuItem(
                                          value: 0,
                                          child: Text('View Album'),
                                        ),
                                        PopupMenuItem(
                                          value: 1,
                                          child: Text('View Artist'),
                                        ),
                                        PopupMenuItem(
                                          value: 2,
                                          child: Text('Add to Playlist'),
                                        ),
                                      ]),
                            ),
                            AppSpacing.height30,
                            Container(
                              height: screenHeight * 0.3,
                              width: imageSize,
                              margin:
                                  EdgeInsets.all(isMobile(context) ? 20 : 20),
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: CachedNetworkImageProvider(
                                    currentSong.image?.last.imageUrl ??
                                        errorImage(),
                                  ),
                                  fit: BoxFit.fill,
                                ),
                                borderRadius: BorderRadius.circular(
                                  isMobile(context) ? 15 : 20,
                                ),
                              ),
                            ),
                            SizedBox(height: isMobile(context) ? 40 : 20),
                            Text(
                              currentSong.name ?? "NO",
                              style: TextStyle(
                                fontSize: isMobile(context) ? 35 : 30,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.fade,
                              softWrap: false,
                            ),
                            SizedBox(height: isMobile(context) ? 15 : 10),
                            Text(
                              currentSong.artists?.all != null &&
                                      currentSong.artists!.all!.isNotEmpty
                                  ? currentSong.artists!.all!
                                      .map((artist) => artist.name)
                                      .join(", ")
                                  : "No Artists Available",
                              maxLines: 1,
                              overflow: TextOverflow.fade,
                              softWrap: false,
                            ),
                            AppSpacing.height10,
                            Row(
                              children: [
                                Spacer(),
                                IconButton(
                                  onPressed: () {
                                    showPlaylistSelectionBottomSheet(
                                      context: context,
                                      song: currentSong,
                                    );
                                  },
                                  icon: Icon(Icons.add_circle_outline_sharp),
                                ),
                                FavoriteIcon(song: currentSong),
                              ],
                            ),
                            AppSpacing.height10,
                            BlocBuilder<ProgressBarCubit, ProgressBarState>(
                              builder: (context, state) {
                                if (state is ProgressBarInitial) {
                                  return ProgressBarWidget(
                                    songDuration: Duration(
                                      seconds: widget
                                              .songs[
                                                  AppGlobals().currentSongIndex]
                                              .duration ??
                                          0,
                                    ),
                                    audioPlayer: AppGlobals().audioHandler,
                                    progressDuration: state.progressDuration,
                                  );
                                }
                                return ProgressBarWidget(
                                  songDuration: Duration(
                                    seconds: widget
                                            .songs[
                                                AppGlobals().currentSongIndex]
                                            .duration ??
                                        0,
                                  ),
                                  audioPlayer: AppGlobals().audioHandler,
                                  progressDuration: Duration.zero,
                                );
                              },
                            ),
                            SizedBox(height: isMobile(context) ? 15 : 20),
                            Row(
                              children: [
                                IconButton(
                                    onPressed: _toggleShuffle,
                                    icon: Icon(
                                      Icons.shuffle,
                                      color: theme.brightness == Brightness.dark
                                          ? _shuffle
                                              ? AppColors.white
                                              : AppColors.grey800
                                          : _shuffle
                                              ? AppColors.black
                                              : AppColors.grey,
                                    )),
                                const Spacer(),
                                IconButton(
                                  onPressed: _playPrevious,
                                  icon: Icon(
                                    Icons.skip_previous_rounded,
                                    size: fontSize,
                                    color: AppGlobals().currentSongIndex == 0
                                        ? AppColors.iconDisable
                                        : null,
                                  ),
                                ),
                                BlocBuilder<PlayAndPauseCubit,
                                    PlayAndPauseState>(
                                  builder: (context, state) {
                                    if (state is PlayingState) {
                                      return IconButton(
                                        onPressed: () {
                                          AppGlobals().audioHandler.play();
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
                                          AppGlobals().audioHandler.pause();
                                        },
                                        icon: Icon(
                                          Icons.pause_circle_filled,
                                          size: fontSize * 1.2,
                                        ),
                                      );
                                    }
                                    if (state is LoadingState) {
                                      return SizedBox(
                                        height: fontSize,
                                        width: fontSize,
                                        child: theme.brightness ==
                                                Brightness.dark
                                            ? Lottie.asset(
                                                "assets/animations/light_music_loading.json",
                                                fit: BoxFit.cover)
                                            : Lottie.asset(
                                                "assets/animations/dark_music_loading.json",
                                              ),
                                      );
                                    }
                                    return SizedBox(
                                      height: fontSize,
                                      width: fontSize,
                                      child: theme.brightness == Brightness.dark
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
                                  icon: Icon(
                                    Icons.skip_next_rounded,
                                    size: fontSize,
                                    color: AppGlobals().currentSongIndex ==
                                            ((widget.songs.length) - 1)
                                        ? AppColors.iconDisable
                                        : null,
                                  ),
                                ),
                                const Spacer(),
                                IconButton(
                                  onPressed: () {
                                    DownloadSongRepo.downloadSong(
                                      downloadUrl:
                                          currentSong.downloadUrl?.last.link ??
                                              "",
                                      fileName: currentSong.name ?? "Nothing",
                                    );
                                  },
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
                color: AppColors.transparent,
                child: _buildSongList(context),
              )
          ],
        ),
      ),
    );
  }

//------------ for mobile view ----------------------------
  IconButton songListMobile(ThemeData theme, BuildContext context) {
    return IconButton(
      onPressed: () {
        _scrollToCurrentSong();

        showModalBottomSheet(
          backgroundColor: theme.brightness == Brightness.dark
              ? AppColors.black.withOpacity(0.7)
              : AppColors.white.withOpacity(0.7),
          context: context,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          builder: (BuildContext context) {
            ScrollController modalScrollController = ScrollController();

            WidgetsBinding.instance.addPostFrameCallback((_) {
              const double itemHeight = 72;
              final double scrollPosition =
                  (AppGlobals().currentSongIndex * itemHeight) -
                      (itemHeight * 1.5);

              if (modalScrollController.hasClients) {
                modalScrollController.animateTo(
                  scrollPosition,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              }
            });

            return StatefulBuilder(
              builder: (BuildContext context, StateSetter setModalState) {
                return Padding(
                  padding: const EdgeInsets.all(10),
                  child: ReorderableListView(
                    scrollController: modalScrollController,
                    onReorder: (oldIndex, newIndex) {
                      setModalState(() {
                        if (newIndex > oldIndex) {
                          newIndex -= 1;
                        }
                        final moveSong = widget.songs.removeAt(oldIndex);
                        widget.songs.insert(newIndex, moveSong);

                        if (AppGlobals().currentSongIndex == oldIndex) {
                          AppGlobals().setCurrentSongIndex(newIndex);
                        } else if (AppGlobals().currentSongIndex > oldIndex &&
                            AppGlobals().currentSongIndex <= newIndex) {
                          AppGlobals()
                              .setColorIndex(AppGlobals().currentSongIndex - 1);
                        } else if (AppGlobals().currentSongIndex < oldIndex &&
                            AppGlobals().currentSongIndex >= newIndex) {
                          AppGlobals().setCurrentSongIndex(
                              AppGlobals().currentSongIndex + 1);
                        }

                        AppGlobals().audioHandler.setMediaItems(
                              mediaItems: widget.songs
                                  .map((song) => MediaItem(
                                        id: song.downloadUrl?.last.link ?? "",
                                        album: song.album?.name ?? "No ",
                                        title: song.label ?? "No ",
                                        displayTitle: song.name,
                                        duration: Duration(
                                            seconds: song.duration ?? 0),
                                        artUri: Uri.parse(
                                            song.image?.last.imageUrl ??
                                                errorImage()),
                                      ))
                                  .toList(),
                              currentIndex: AppGlobals().currentSongIndex,
                              songList: widget.songs,
                            );
                      });
                    },
                    children: List.generate(
                      widget.songs.length,
                      (index) {
                        return ListTile(
                          key: ValueKey(widget.songs[index].id),
                          onTap: () {
                            Navigator.of(context).pop();
                            if (index != AppGlobals().currentSongIndex) {
                              AppGlobals().audioHandler.stop();
                              setState(() {
                                AppGlobals().setCurrentSongIndex(index);
                                hasPlayed = false;
                              });
                              _initializeAudioHandler(chage: false);
                              _scrollToCurrentSong();
                            }
                          },
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              AppGlobals().currentSongIndex == index
                                  ? Lottie.asset(
                                      Theme.of(context).brightness ==
                                              Brightness.dark
                                          ? "assets/animations/musicPlaying_light.json"
                                          : "assets/animations/musicPlaying_dark.json",
                                      height: 50,
                                      width: 50,
                                    )
                                  : const SizedBox(),
                              FavoriteIcon(song: widget.songs[index]),
                            ],
                          ),
                          leading: Container(
                            width: 60,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: CachedNetworkImageProvider(
                                    widget.songs[index].image?.last.imageUrl ??
                                        errorImage()),
                                fit: BoxFit.fill,
                              ),
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          title: Text(
                            widget.songs[index].name ?? "No",
                            maxLines: 1,
                            style: TextStyle(
                              color: AppGlobals().currentSongIndex == index
                                  ? AppColors.colorList[AppGlobals().colorIndex]
                                  : null,
                            ),
                          ),
                          subtitle: Text(
                            widget.songs[index].label ?? "No",
                            maxLines: 1,
                            style: TextStyle(
                              color: AppGlobals().currentSongIndex == index
                                  ? AppColors.colorList[AppGlobals().colorIndex]
                                  : null,
                            ),
                          ),
                        );
                      },
                    ),
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

//------------- for tab and desktop ------------
  Widget _buildSongList(BuildContext context) {
    return ReorderableListView(
      scrollController: _scrollController,
      onReorder: (oldIndex, newIndex) {
        setState(
          () {
            if (newIndex > oldIndex) {
              newIndex -= 1;
            }
            final moveSong = widget.songs.removeAt(oldIndex);
            widget.songs.insert(newIndex, moveSong);
            if (AppGlobals().currentSongIndex == oldIndex) {
              AppGlobals().setCurrentSongIndex(newIndex);
            } else if (AppGlobals().currentSongIndex > oldIndex &&
                AppGlobals().currentSongIndex <= newIndex) {
              AppGlobals().setCurrentSongIndex(AppGlobals().colorIndex - 1);
            } else if (AppGlobals().currentSongIndex < oldIndex &&
                AppGlobals().currentSongIndex >= newIndex) {
              AppGlobals()
                  .setCurrentSongIndex(AppGlobals().currentSongIndex + 1);
            }
            AppGlobals().audioHandler.setMediaItems(
                mediaItems: widget.songs
                    .map((song) => MediaItem(
                          id: song.downloadUrl?.last.link ?? "",
                          album: song.album?.name ?? "No ",
                          title: song.label ?? "No ",
                          displayTitle: song.name,
                          duration: Duration(seconds: song.duration ?? 0),
                          artUri: Uri.parse(
                              song.image?.last.imageUrl ?? errorImage()),
                        ))
                    .toList(),
                currentIndex: AppGlobals().currentSongIndex,
                songList: widget.songs);
          },
        );
      },
      children: List.generate(
        widget.songs.length,
        (index) {
          return ListTile(
            key: ValueKey(widget.songs[index].id),
            onTap: () {
              if (index != AppGlobals().currentSongIndex) {
                AppGlobals().audioHandler.stop();
                setState(() {
                  AppGlobals().setCurrentSongIndex(index);
                  hasPlayed = false;
                });
                _initializeAudioHandler(chage: false);
                _scrollToCurrentSong();
              }
            },
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                AppGlobals().currentSongIndex == index
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
                    widget.songs[index].image?.last.imageUrl ?? errorImage(),
                  ),
                  fit: BoxFit.fill,
                ),
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            title: Text(
              widget.songs[index].name ?? "No",
              maxLines: 1,
              style: TextStyle(
                color: AppGlobals().currentSongIndex == index
                    ? AppColors.colorList[AppGlobals().colorIndex]
                    : null,
              ),
            ),
            subtitle: Text(
              widget.songs[index].label ?? "No",
              maxLines: 1,
              style: TextStyle(
                color: AppGlobals().currentSongIndex == index
                    ? AppColors.colorList[AppGlobals().colorIndex]
                    : null,
              ),
            ),
          );
        },
      ),
    );
  }
}
