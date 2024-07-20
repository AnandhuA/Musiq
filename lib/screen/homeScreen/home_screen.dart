import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musiq/bloc/FeatchSongsBloc/featch_songs_bloc.dart';
import 'package:musiq/models/song_model.dart';
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
      body: BlocConsumer<FeatchSongsBloc, FeatchSongsState>(
        listener: (context, state) {
          if (state is FeatchSongsSuccess) {
            log("set");
          }
        },
        builder: (context, state) {
          if (state is FeatchSongsLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is FeatchSongsFailure) {
            return Center(
              child: Image.network(
                "https://image.tmdb.org/t/p/w500/1E5baAaEse26fej7uHcjOgEE2t2.jpg",
              ),
            );
          } else if (state is FeatchSongsSuccess) {
            final bloc = BlocProvider.of<FeatchSongsBloc>(context);
            return ListView.builder(
              itemCount: state.songList.length,
              itemBuilder: (context, index) {
                final song = state.songList[index];

                return StreamBuilder<SongModel>(
                  stream:
                      bloc.songStream.where((s) => s.songUrls == song.songUrls),
                  builder: (context, snapshot) {
                    final updatedSong = snapshot.data ?? song;

                    return ListTile(
                      onTap: () {
                        log("Navigating to player screen");
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PlayerScreen(
                              songList: state.songList,
                              currentIndex: index,
                            ),
                          ),
                        );
                      },
                      leading: updatedSong.imgFile == null
                          ? Image.asset(
                              "assets/images/music.jpg",
                              width: 50,
                            )
                          : Image.memory(updatedSong.imgFile!,
                              width: 50, fit: BoxFit.cover),
                      title: Text(updatedSong.songName),
                      subtitle: Text(updatedSong.artist),
                    );
                  },
                );
              },
            );
          }
          return Center(
            child: Text("Unknown state$state"),
          );
        },
      ),
    );
  }
}
