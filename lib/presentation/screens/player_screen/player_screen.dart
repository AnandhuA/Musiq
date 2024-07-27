import 'dart:ui';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:musiq/data/shared_preference.dart';
import 'package:musiq/main.dart';
import 'package:musiq/models/song.dart';
import 'package:musiq/presentation/commanWidgets/custom_app_bar.dart';
import 'package:musiq/presentation/commanWidgets/favorite_icon.dart';
import 'package:musiq/presentation/screens/player_screen/cubit/PlayAndPause/play_and_pause_cubit.dart';
import 'package:musiq/presentation/screens/player_screen/cubit/ProgressBar/progress_bar_cubit.dart';
import 'package:musiq/presentation/screens/player_screen/widgets/progress_bar_widget.dart';

class PlayerScreen extends StatefulWidget {
  final Song song;
  const PlayerScreen({super.key, required this.song});

  @override
  State<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  late AudioPlayer _audioPlayer;
  bool _hasPlayed = false;

  @override
  void initState() {
    super.initState();
    context.read<PlayAndPauseCubit>().reset();
    context.read<ProgressBarCubit>().reset();
    lastplayed = widget.song;
    SharedPreference.lastPlayedSong(widget.song);
    _audioPlayer = AudioPlayer();

    _audioPlayer.setSource(UrlSource(widget.song.downloadUrl.last.url)).then(
      (_) {
        _audioPlayer.getDuration().then(
              (duration) {},
            );
        if (!_hasPlayed) {
          _audioPlayer.play(
            UrlSource(
              widget.song.downloadUrl.last.url,
            ),
          );
          setState(() {
            _hasPlayed = true;
          });
        }
      },
    );

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
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(widget.song.image.first.url),
              alignment: const Alignment(1, -1),
              fit: BoxFit.fitWidth,
            ),
          ),
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 100,
              sigmaY: 100,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    CustomAppBar(
                      title: widget.song.album.name,
                    ),
                    Container(
                      height: screenHeight * 0.36,
                      width: screenWidth * 0.8,
                      margin: const EdgeInsets.all(30),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(
                            widget.song.image.last.url,
                          ),
                          fit: BoxFit.fill,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    Text(
                      widget.song.name ?? "no name",
                      style: TextStyle(
                        fontSize: screenWidth * 0.1,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.fade,
                      softWrap: false,
                    ),
                    SizedBox(height: screenHeight * 0.01),
                    Text(
                      widget.song.artists.all
                          .map((artist) => artist.name)
                          .join(' | '),
                      maxLines: 1,
                      overflow: TextOverflow.fade,
                      softWrap: false,
                    ),
                    SizedBox(height: screenHeight * 0.05),
                    BlocBuilder<ProgressBarCubit, ProgressBarState>(
                      builder: (context, state) {
                        if (state is ProgressBarInitial) {
                          return ProgressBarWidget(
                            widget: widget,
                            audioPlayer: _audioPlayer,
                            progressDuration: state.progressDuration,
                          );
                        }
                        return ProgressBarWidget(
                          widget: widget,
                          audioPlayer: _audioPlayer,
                          progressDuration: Duration.zero,
                        );
                      },
                    ),
                    SizedBox(height: screenHeight * 0.03),
                    Row(
                      children: [
                        FavoriteIcon(song: widget.song),
                        const Spacer(),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.skip_previous_rounded,
                            size: screenWidth * 0.12,
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
                                  size: screenWidth * 0.14,
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
                                  size: screenWidth * 0.14,
                                ),
                              );
                            }
                            return SizedBox(
                              height: screenWidth * 0.12,
                              width: screenWidth * 0.12,
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
                          onPressed: () {},
                          icon: Icon(
                            Icons.skip_next_rounded,
                            size: screenWidth * 0.12,
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
    );
  }
}
