import 'dart:developer';
import 'dart:ui';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:musiq/core/colors.dart';
import 'package:musiq/core/sized.dart';
import 'package:musiq/data/shared_preference.dart';
import 'package:musiq/main.dart';
import 'package:musiq/models/song.dart';
import 'package:musiq/presentation/commanWidgets/custom_app_bar.dart';
import 'package:musiq/presentation/commanWidgets/favorite_icon.dart';
import 'package:musiq/presentation/screens/player_screen/cubit/PlayAndPause/play_and_pause_cubit.dart';
import 'package:musiq/presentation/screens/player_screen/cubit/ProgressBar/progress_bar_cubit.dart';
import 'package:musiq/presentation/screens/player_screen/widgets/progress_bar_widget.dart';

class PlayerScreen extends StatefulWidget {
  final List<Song> songs;
  final int initialIndex;

  const PlayerScreen({super.key, required this.songs, this.initialIndex = 0});

  @override
  State<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  late AudioPlayer _audioPlayer;
  late int _currentIndex;
  late ScrollController _scrollController;

  bool _hasPlayed = false;

  Song get currentSong => widget.songs[_currentIndex];

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _scrollController = ScrollController();
    _initializePlayer();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToCurrentSong();
    });
  }

  void _initializePlayer() {
    context.read<PlayAndPauseCubit>().reset();
    context.read<ProgressBarCubit>().reset();
    lastplayed = currentSong;
    SharedPreference.lastPlayedSong(currentSong);
    _audioPlayer = AudioPlayer();

    _audioPlayer.setSource(UrlSource(currentSong.downloadUrl.last.url)).then(
      (_) {
        _audioPlayer.getDuration().then(
              (duration) {},
            );
        if (!_hasPlayed) {
          _audioPlayer.play(UrlSource(currentSong.downloadUrl.last.url));
          setState(() {
            _hasPlayed = true;
          });
        }
      },
    ).catchError((error) {
      log('Error setting audio source: $error');
    });

    _audioPlayer.onPlayerStateChanged.listen(
      (state) {
        if (mounted) {
          context.read<PlayAndPauseCubit>().togglePlayerState(state);
        }
      },
    );

    _audioPlayer.onPositionChanged.listen(
      (position) {
        if (mounted) {
          context.read<ProgressBarCubit>().changeProgress(position);
        }
      },
    );

    _audioPlayer.onPlayerComplete.listen((event) {
      _playNext();
    });
  }

  void _playNext() {
    if (_currentIndex < widget.songs.length - 1) {
      _audioPlayer.stop();
      setState(() {
        _currentIndex++;
        _hasPlayed = false;
        _initializePlayer();
      });
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _scrollToCurrentSong();
      });
    }
  }

  void _playPrevious() {
    if (_currentIndex > 0) {
      _audioPlayer.stop();
      setState(() {
        _currentIndex--;
        _hasPlayed = false;
        _initializePlayer();
      });
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _scrollToCurrentSong();
      });
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
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

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
                    image: NetworkImage(currentSong.image.first.url),
                    alignment: isMobile(context)
                        ? const Alignment(1, -2)
                        : const Alignment(1, 20),
                    fit: BoxFit.fitWidth,
                  ),
                ),
                child: BackdropFilter(
                  filter: ImageFilter.blur(
                    sigmaX: 100,
                    sigmaY: 100,
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: isMobile(context) ? 10 : 100),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          CustomAppBar(
                            title: currentSong.album.name,
                          ),
                          constHeight30,
                          Container(
                            height: screenHeight * 0.3,
                            width: imageSize,
                            margin:
                                EdgeInsets.all(isMobile(context) ? 20 : 100),
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(currentSong.image.last.url),
                                fit: BoxFit.fill,
                              ),
                              borderRadius: BorderRadius.circular(
                                  isMobile(context) ? 15 : 20),
                            ),
                          ),
                          SizedBox(height: isMobile(context) ? 50 : 20),
                          Text(
                            currentSong.name ?? "no name",
                            style: TextStyle(
                              fontSize: isMobile(context) ? 35 : 50,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.fade,
                            softWrap: false,
                          ),
                          SizedBox(height: isMobile(context) ? 15 : 10),
                          Text(
                            currentSong.artists.all
                                .map((artist) => artist.name)
                                .join(' | '),
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
                                  audioPlayer: _audioPlayer,
                                  progressDuration: state.progressDuration,
                                );
                              }
                              return ProgressBarWidget(
                                song: widget.songs[_currentIndex],
                                audioPlayer: _audioPlayer,
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
                                ),
                              ),
                              BlocBuilder<PlayAndPauseCubit, PlayAndPauseState>(
                                builder: (context, state) {
                                  if (state is PlayingState) {
                                    return IconButton(
                                      onPressed: () {
                                        _audioPlayer.resume();
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
                                        _audioPlayer.pause();
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
                                icon: Icon(
                                  Icons.skip_next_rounded,
                                  size: fontSize,
                                ),
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
                        ],
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
                child: ListView.builder(
                  controller: _scrollController,
                  itemCount: widget.songs.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      onTap: () {
                        if (index != _currentIndex) {
                          _audioPlayer.stop();
                          setState(() {
                            _currentIndex = index;
                            _hasPlayed = false;
                          });
                          _initializePlayer();
                          _scrollToCurrentSong();
                        }
                      },
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _currentIndex == index
                              ? Lottie.asset(
                                  Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? "assets/animations/musicPlaying_light.json"
                                      : "assets/animations/musicPlaying_dark.json",
                                )
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
                            image: NetworkImage(
                              widget.songs[index].image.first.url,
                            ),
                            fit: BoxFit.fill,
                          ),
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      title: Text(
                        widget.songs[index].name ?? "Unknown",
                      ),
                      subtitle: Text(widget.songs[index].album.name),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
