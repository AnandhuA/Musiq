import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musiq/bloc/playlist/play_list_cubit.dart';
import 'package:musiq/core/colors.dart';
import 'package:musiq/core/global_variables.dart';
import 'package:musiq/core/helper_funtions.dart';
import 'package:musiq/models/playlist_model_hive/playlist_model.dart';
import 'package:musiq/models/song_model/song.dart';
import 'package:musiq/presentation/commanWidgets/dismissible_funtion.dart';
import 'package:musiq/presentation/commanWidgets/empty_screen.dart';
import 'package:musiq/presentation/screens/player_screen/bottomPlayer/bottom_player.dart';
import 'package:musiq/presentation/screens/player_screen/player_screen.dart';

class ViewPlaylistScreen extends StatefulWidget {
  final PlaylistModelHive model;
  const ViewPlaylistScreen({
    super.key,
    required this.model,
  });

  @override
  State<ViewPlaylistScreen> createState() => _ViewPlaylistScreenState();
}

class _ViewPlaylistScreenState extends State<ViewPlaylistScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios_new_sharp,
            ),
          ),
          title: Text(widget.model.name),
        ),
        body: Stack(
          children: [
            widget.model.songList.isNotEmpty
                ? ListView.builder(
                    padding: EdgeInsets.only(bottom: 100),
                    itemCount: widget.model.songList.length,
                    itemBuilder: (context, index) {
                      final song = widget.model.songList[index];
                      return Dismissible(
                        key: Key(song.id ?? index.toString()),
                        direction: DismissDirection.horizontal,
                        confirmDismiss: (direction) => reusableConfirmDismiss(
                          context: context,
                          song: song,
                        ),
                        background: Container(
                            color: AppColors.green,
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Icon(Icons.wrap_text_sharp),
                                Icon(Icons.wrap_text_sharp),
                              ],
                            )),
                        child: ListTile(
                          onLongPress: () {
                            _showRemoveSongDialog(context, index);
                          },
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PlayerScreen(
                                    songs: widget.model.songList,
                                    initialIndex: index,
                                  ),
                                ));
                          },
                          leading: CachedNetworkImage(
                            imageUrl: song.image?.last.imageUrl ?? errorImage(),
                            placeholder: (context, url) =>
                                songImagePlaceholder(),
                            errorWidget: (context, url, error) =>
                                songImagePlaceholder(),
                          ),
                          title: Text(song.name ?? "Nothig"),
                          subtitle: Text(song.label ?? "No"),
                        ),
                      );
                    },
                  )
                : EmptyScreen(
                    text1: "show",
                    size1: 15,
                    text2: "Nothing",
                    size2: 20,
                    text3: "AddSongs",
                    size3: 20,
                  ),
            ValueListenableBuilder<List<Song>>(
              valueListenable: AppGlobals().lastPlayedSongNotifier,
              builder: (context, lastPlayedSongs, _) {
                if (lastPlayedSongs.isNotEmpty) {
                  return MiniPlayer(
                    bottomPosition: 16,
                  );
                }
                return SizedBox();
              },
            ),
          ],
        ));
  }

  void _showRemoveSongDialog(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Remove Song'),
          content: Text(
              'Are you sure you want to remove this song from the playlist?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                context.read<PlayListCubit>().removeSongFromPlayList(
                    playlist: widget.model, song: widget.model.songList[index]);

                Navigator.of(context).pop();
                setState(() {
                  widget.model.songList.removeAt(index);
                });
              },
              child: Text('Remove'),
            ),
          ],
        );
      },
    );
  }
}
