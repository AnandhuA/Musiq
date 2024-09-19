import 'package:flutter/material.dart';
import 'package:musiq/core/colors.dart';
import 'package:musiq/core/sized.dart';
import 'package:musiq/main.dart';
import 'package:musiq/models/song_model.dart';
import 'package:musiq/presentation/commanWidgets/favorite_icon.dart';
import 'package:musiq/presentation/screens/player_screen/player_screen.dart';

class AlbumOrPlaylistScreen extends StatelessWidget {
  final List<SongModel> songModel;
  final String? imageUrl;
  final String title;
  const AlbumOrPlaylistScreen({
    super.key,
    required this.songModel,
    this.imageUrl,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.all(10),
            child: Row(
              children: [
                Container(
                  width: 220,
                  height: 200,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      imageUrl ?? songModel.first.imageUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                constWidth20,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 5,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: colorList[colorIndex],
                        ),
                      ),
                      Text(
                        "${songModel.length}-songs",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 5,
                      ),
                      songModel.isNotEmpty
                          ? Text(
                              songModel.first.language,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 5,
                            )
                          : SizedBox(),
                      songModel.isNotEmpty
                          ? Text(
                              songModel.first.albumArtist,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 5,
                            )
                          : SizedBox(),
                      constHeight10,
                      Row(
                        children: [
                          Spacer(),
                          GestureDetector(
                            onTap: () {
                              songModel.isNotEmpty
                                  ? Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => PlayerScreen(
                                          songs: songModel,
                                        ),
                                      ))
                                  : null;
                            },
                            child: CircleAvatar(
                              backgroundColor: colorList[colorIndex],
                              radius: 28,
                              child: Center(
                                child: Icon(
                                  Icons.play_arrow_sharp,
                                  size: 35,
                                  color: theme.brightness == Brightness.dark
                                      ? Colors.black
                                      : Colors.white,
                                ),
                              ),
                            ),
                          ),
                          constWidth20
                        ],
                      )
                    ],
                  ),
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
