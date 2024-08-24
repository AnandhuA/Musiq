import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:musiq/core/colors.dart';
import 'package:musiq/core/sized.dart';
import 'package:musiq/main.dart';
import 'package:musiq/presentation/commanWidgets/textfeild.dart';
import 'package:musiq/presentation/screens/homeScreen/suggestion/bloc/Trending/trending_cubit.dart';
import 'package:musiq/presentation/screens/homeScreen/widgets/drawer_widget.dart';
import 'package:musiq/presentation/screens/searchScreen/search_screen.dart';
import 'package:musiq/presentation/screens/settingsScreen/ThemeCubit/theme_cubit.dart';
import 'package:musiq/presentation/screens/homeScreen/suggestion/bloc/EngSong/english_song_suggestion_bloc.dart';
import 'package:musiq/presentation/screens/homeScreen/suggestion/bloc/HindiSong/hindi_song_bloc.dart';
import 'package:musiq/presentation/screens/homeScreen/suggestion/bloc/MalayalamSongs/mal_songs_bloc.dart';
import 'package:musiq/presentation/screens/homeScreen/suggestion/bloc/TamilSongs/tamil_song_bloc.dart';

import 'package:musiq/presentation/screens/homeScreen/suggestion/suggestion.dart';
import 'package:musiq/presentation/screens/homeScreen/suggestion/widgets/shimmer_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Music',
              style: TextStyle(
                color: accentColors[colorIndex],
                fontWeight: FontWeight.bold,
              ),
            ),
            actions: [
              Lottie.asset("assets/animations/Animation1.json"),
            ],
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(60),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(18),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SearchScreen(),
                          ));
                    },
                    child: AbsorbPointer(
                      child: CustomTextFeild(
                        hintText: "Search",
                        icon: Icon(
                          Icons.search,
                          color: accentColors[colorIndex],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          drawer: const DrawerWidget(),
          body: SingleChildScrollView(
            child: Column(
              children: [
                constHeight20,
                //--------------Ternding-------------------------
                BlocBuilder<TrendingCubit, TrendingState>(
                  builder: (context, state) {
                    if (state is TrendingLoading) {
                      return const SuggetionShimmerWidget(
                        title: "Ternding",
                      );
                    } else if (state is TrendingLoaded) {
                      return Suggestion(
                        title: "Ternding",
                        suggetionSongs: state.songs,
                      );
                    } else {
                      return SizedBox(
                        height: 200,
                        child: Center(
                          child: TextButton(
                            onPressed: () {
                              context
                                  .read<TrendingCubit>()
                                  .fetchTrendingSongs();
                            },
                            child: Text(
                              "Retry",
                              style: TextStyle(
                                color: accentColors[colorIndex],
                              ),
                            ),
                          ),
                        ),
                      );
                    }
                  },
                ),
                constHeight20,
                //---------------malayalam-------------------------
                BlocBuilder<MalSongsBloc, MalSongsState>(
                  builder: (context, state) {
                    if (state is MalSongsLoaded) {
                      return Suggestion(
                        title: "Malayalam",
                        suggetionSongs: state.songs,
                      );
                    } else if (state is MalSongsLoading) {
                      return const SuggetionShimmerWidget(
                        title: "Malayalam",
                      );
                    } else {
                      return SizedBox(
                        height: 200,
                        child: Center(
                          child: TextButton(
                            onPressed: () {
                              context.read<MalSongsBloc>().add(MalSongsEvent());
                            },
                            child: Text(
                              "Retry",
                              style: TextStyle(
                                color: accentColors[colorIndex],
                              ),
                            ),
                          ),
                        ),
                      );
                    }
                  },
                ),
                const SizedBox(height: 25),
                //----------------Tamil-------------------------
                BlocBuilder<TamilSongBloc, TamilSongState>(
                  builder: (context, state) {
                    if (state is TamilSongLoaded) {
                      return Suggestion(
                        title: "Tamil",
                        suggetionSongs: state.songs,
                      );
                    } else if (state is TamilSongLoading) {
                      return const SuggetionShimmerWidget(
                        title: "Tamil",
                      );
                    } else {
                      return SizedBox(
                        height: 200,
                        child: Center(
                          child: TextButton(
                            onPressed: () {
                              context
                                  .read<TamilSongBloc>()
                                  .add(TamilSongEvent());
                            },
                            child: Text(
                              "Retry",
                              style: TextStyle(
                                color: accentColors[colorIndex],
                              ),
                            ),
                          ),
                        ),
                      );
                    }
                  },
                ),
                const SizedBox(height: 25),
                //---------------------Hindi-------------
                BlocBuilder<HindiSongBloc, HindiSongState>(
                  builder: (context, state) {
                    if (state is HindiSongLoaded) {
                      return Suggestion(
                        title: "Hindi",
                        suggetionSongs: state.songs,
                      );
                    } else if (state is HindiSongLoading) {
                      return const SuggetionShimmerWidget(
                        title: "Hindi",
                      );
                    } else {
                      return SizedBox(
                        height: 200,
                        child: Center(
                          child: TextButton(
                            onPressed: () {
                              context
                                  .read<HindiSongBloc>()
                                  .add(HindiSongEvent());
                            },
                            child: Text(
                              "Retry",
                              style: TextStyle(
                                color: accentColors[colorIndex],
                              ),
                            ),
                          ),
                        ),
                      );
                    }
                  },
                ),
                const SizedBox(height: 25),
                //-------------------------English-----------------
                BlocBuilder<EnglishSongSuggestionBloc,
                    EnglishSongSuggestionState>(
                  builder: (context, state) {
                    if (state is EnglishSongSuggestionLoaded) {
                      return Suggestion(
                        title: "English",
                        suggetionSongs: state.engSongs,
                      );
                    } else if (state is EnglishSongSuggestionLoading) {
                      return const SuggetionShimmerWidget(
                        title: "English",
                      );
                    } else {
                      return SizedBox(
                        height: 200,
                        child: Center(
                          child: TextButton(
                            onPressed: () {
                              context
                                  .read<EnglishSongSuggestionBloc>()
                                  .add(EnglishSongSuggestionEvent());
                            },
                            child: Text(
                              "Retry",
                              style: TextStyle(
                                color: accentColors[colorIndex],
                              ),
                            ),
                          ),
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
