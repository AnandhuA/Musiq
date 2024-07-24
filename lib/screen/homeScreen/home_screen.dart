import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:musiq/core/colors.dart';
import 'package:musiq/core/sized.dart';
import 'package:musiq/main.dart';
import 'package:musiq/screen/commanWidgets/textfeild.dart';
import 'package:musiq/screen/homeScreen/widgets/drawer_widget.dart';
import 'package:musiq/screen/search/search_screen.dart';
import 'package:musiq/screen/settings/ThemeCubit/theme_cubit.dart';
import 'package:musiq/screen/suggestion/bloc/EngSong/english_song_suggestion_bloc.dart';
import 'package:musiq/screen/suggestion/bloc/HindiSong/hindi_song_bloc.dart';
import 'package:musiq/screen/suggestion/bloc/MalayalamSongs/mal_songs_bloc.dart';
import 'package:musiq/screen/suggestion/bloc/TamilSongs/tamil_song_bloc.dart';

import 'package:musiq/screen/suggestion/suggestion.dart';
import 'package:musiq/screen/suggestion/widgets/shimmer_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    context.read<EnglishSongSuggestionBloc>().add(EnglishSongSuggestionEvent());
    context.read<MalSongsBloc>().add(MalSongsEvent());
    context.read<TamilSongBloc>().add(TamilSongEvent());
    context.read<HindiSongBloc>().add(HindiSongEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ThemeCubit, ThemeState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Music Library',
              style: TextStyle(
                color: accentColors[colorIndex],
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
                    child: const AbsorbPointer(
                      child: CustomTextFeild(hintText: "Search"),
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
                    } else if (state is MalSongsError) {
                      return const Center(child: Text('Somthig Wrong'));
                    } else {
                      return const Center(child: Text('Error'));
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
                    } else if (state is TamilSongError) {
                      return const Center(child: Text('Somthig Wrong'));
                    } else {
                      return const Center(child: Text('Error'));
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
                    } else if (state is HindiSongError) {
                      return const Center(child: Text('Somthig Wrong'));
                    } else {
                      return const Center(child: Text('Error'));
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
                    } else if (state is EnglishSongSuggestionError) {
                      return const Center(child: Text('Somthig Wrong'));
                    } else {
                      return const Center(child: Text('Error'));
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
