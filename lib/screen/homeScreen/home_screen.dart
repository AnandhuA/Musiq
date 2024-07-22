import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musiq/screen/suggestion/bloc/EngSong/english_song_suggestion_bloc.dart';
import 'package:musiq/screen/suggestion/bloc/HindiSong/hindi_song_bloc.dart';
import 'package:musiq/screen/suggestion/bloc/MalayalamSongs/mal_songs_bloc.dart';
import 'package:musiq/screen/suggestion/bloc/TamilSongs/tamil_song_bloc.dart';

import 'package:musiq/screen/suggestion/suggestion.dart';

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
    return Scaffold(
      appBar: AppBar(title: const Text('Music Library')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            //---------------malayalam-------------------------------------------
            BlocBuilder<MalSongsBloc, MalSongsState>(
              builder: (context, state) {
                if (state is MalSongsLoaded) {
                  return Suggestion(
                    title: "Malayalam",
                    suggetionSongs: state.songs,
                  );
                } else {
                  return const Center(child: Text('Error'));
                }
              },
            ),
            const SizedBox(height: 25),
            //----------------Tamil-------------------------------------------
            BlocBuilder<TamilSongBloc, TamilSongState>(
              builder: (context, state) {
                if (state is TamilSongLoaded) {
                  return Suggestion(
                    title: "Tamil",
                    suggetionSongs: state.songs,
                  );
                } else {
                  return const Center(child: Text('Error'));
                }
              },
            ),
            const SizedBox(height: 25),
            //---------------------Hindi-----------------------
            BlocBuilder<HindiSongBloc, HindiSongState>(
              builder: (context, state) {
                if (state is HindiSongLoaded) {
                  return Suggestion(
                    title: "Hindi",
                    suggetionSongs: state.songs,
                  );
                } else {
                  return const Center(child: Text('Error'));
                }
              },
            ),
            const SizedBox(height: 25),
            //-------------------------English-------------------------------------------
            BlocBuilder<EnglishSongSuggestionBloc, EnglishSongSuggestionState>(
              builder: (context, state) {
                if (state is EnglishSongSuggestionLoaded) {
                  return Suggestion(
                    title: "English",
                    suggetionSongs: state.engSongs,
                  );
                } else {
                  return const Center(child: Text('Error'));
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
