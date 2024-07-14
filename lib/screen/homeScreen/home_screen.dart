import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musiq/FeatchSongsBloc/featch_songs_bloc.dart';

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
                if (song.imgFile == null) {
                  return ListTile(
                    leading: const CircleAvatar(),
                    title: Text(song.album),
                    subtitle: Text(song.artist),
                  );
                }

                return ListTile(
                  leading: song.imgFile == null
                      ? const CircleAvatar()
                      : Image.memory(song.imgFile!),
                  title: Text(song.album),
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
