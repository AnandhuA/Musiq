import 'package:flutter/material.dart';
import 'package:musiq/core/sized.dart';
import 'package:musiq/models/song_model.dart';
import 'package:musiq/presentation/commanWidgets/favorite_icon.dart';
import 'package:musiq/presentation/screens/player_screen/player_screen.dart';

class AlbumOrPlaylistScreen extends StatelessWidget {
  final List<SongModel> songModel;
  const AlbumOrPlaylistScreen({super.key, required this.songModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Container(
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    songModel.first.imageUrl,
                    scale: 2,
                  ),
                ),
                constWidth20,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(songModel.first.album),
                    Text("${songModel.length}-songs"),
                    Text(songModel.first.language),
                    Text(songModel.first.albumArtist),
                  ],
                )
              ],
            ),
          ),
          constHeight30,
          Expanded(
            child: ListView.builder(
              itemCount: songModel.length,
              itemBuilder: (context, index) {
                final song = songModel[index];
                return ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PlayerScreen(
                            songs: songModel,
                            initialIndex: index,
                          ),
                        ));
                  },
                  leading: ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Image.network(song.imageUrl)),
                  title: Text(song.title),
                  subtitle: Text(song.subtitle),
                  trailing: FavoriteIcon(song: song),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
