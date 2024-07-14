import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musiq/FeatchSongsBloc/featch_songs_bloc.dart';
import 'package:musiq/screen/player_screen/player_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    context.read<FeatchSongsBloc>().add(FeatchAllSongsEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Music Library')),
      body: BlocBuilder<FeatchSongsBloc, FeatchSongsState>(
        builder: (context, state) {
          if (state is FeatchSongsLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is FeatchSongsFailure) {
            return const Center(
              child: Text("Error:"),
            );
          } else if (state is FeatchSongsSuccess) {
            return ListView.builder(
              itemCount: state.songList.length,
              itemBuilder: (context, index) {
                final song = state.songList[index];

                return ListTile(
                  onTap: () {
                    log("message");
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PlayerScreen(song: song),
                        ));
                  },
                  leading: song.imgFile == null
                      ? Image.asset(
                          "assets/images/music.jpg",
                          width: 50,
                        )
                      : Image.memory(song.imgFile!),
                  title: Text(song.songName),
                  subtitle: Text(song.artist),
                );
              },
            );
          }
          return const Center(
            child: Text("Unknown state"),
          );
        },
      ),
    );
  }
}
