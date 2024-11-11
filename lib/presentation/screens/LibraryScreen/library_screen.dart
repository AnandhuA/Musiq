import 'package:flutter/material.dart';
import 'package:musiq/presentation/screens/libraryScreen/LastPlayed/last_played_list.dart';
import 'package:musiq/presentation/screens/libraryScreen/downloadList/download_list.dart';
import 'package:musiq/presentation/screens/libraryScreen/favoriteScreen/favorite_screen.dart';

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
                    builder: (context) => LastPlayedList(),
                  ));
            },
            leading: Icon(Icons.history_sharp),
            title: Text("Last Played"),
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
