import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musiq/bloc/playlist/play_list_cubit.dart';
import 'package:musiq/presentation/screens/LibraryScreen/history/history.dart';
import 'package:musiq/presentation/screens/libraryScreen/downloadList/download_list.dart';
import 'package:musiq/presentation/screens/libraryScreen/favoriteScreen/favorite_screen.dart';
import 'package:musiq/presentation/screens/libraryScreen/playlist.dart/playlist_screen.dart';

class LibraryScreen extends StatelessWidget {
  const LibraryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ListTile(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FavoriteScreen(),
                  ));
            },
            leading: Icon(Icons.favorite),
            title: Text("Favorite"),
          ),
          ListTile(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => History(),
                  ));
            },
            leading: Icon(Icons.history_sharp),
            title: Text("History"),
          ),
          ListTile(
            onTap: () {
              context.read<PlayListCubit>().FetchPlayList();
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PlaylistScreen(),
                  ));
            },
            leading: Icon(Icons.playlist_add),
            title: Text("PlayLists"),
          ),
          ListTile(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DownloadList(),
                  ));
            },
            leading: Icon(Icons.download),
            title: Text("Downloads"),
          )
        ],
      ),
    );
  }
}
