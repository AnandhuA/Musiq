import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musiq/bloc/playlist/play_list_cubit.dart';
import 'package:musiq/core/colors.dart';
import 'package:musiq/core/global_variables.dart';
import 'package:musiq/models/playlist_model/playlist_model.dart';
import 'package:musiq/models/song_model/song.dart';
import 'package:musiq/presentation/commanWidgets/empty_screen.dart';
import 'package:musiq/presentation/screens/libraryScreen/playlist.dart/view_playlist_screen.dart';
import 'package:musiq/presentation/screens/player_screen/bottomPlayer/bottom_player.dart';

class PlaylistScreen extends StatelessWidget {
  const PlaylistScreen({super.key});

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
        title: Text("Playlist"),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              ListTile(
                leading: Icon(
                  Icons.playlist_add,
                  size: 35,
                ),
                title: Text("Add New PlayList"),
                onTap: () {
                  _showAddPlaylistDialog(context);
                },
              ),
              Expanded(
                child: BlocBuilder<PlayListCubit, PlayListState>(
                  builder: (context, state) {
                    if (state is PlayListLoadingState) {
                      CircularProgressIndicator(
                        color: AppColors.colorList[AppGlobals().colorIndex],
                      );
                    } else if (state is FeatchPlayListSuccessState) {
                      return state.playlistList.isNotEmpty
                          ? ListView.builder(
                              padding: EdgeInsets.only(bottom: 100),
                              itemCount: state.playlistList.length,
                              itemBuilder: (context, index) {
                                final playlist = state.playlistList[index];
                                return ListTile(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              ViewPlaylistScreen(
                                                  model: playlist),
                                        ));
                                  },
                                  leading: CircleAvatar(
                                    child: Text(playlist.name[0]),
                                  ),
                                  title: Text(playlist.name),
                                );
                              },
                            )
                          : emptyScreen(
                              context: context,
                              text1: "show",
                              size1: 15,
                              text2: "Nothing",
                              size2: 20,
                              text3: "Playlist",
                              size3: 20,
                            );
                    }
                    return emptyScreen(
                      context: context,
                      text1: "show",
                      size1: 15,
                      text2: "Nothing",
                      size2: 20,
                      text3: "Playlist",
                      size3: 20,
                    );
                  },
                ),
              ),
            ],
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
      ),
    );
  }

  Future<void> _showAddPlaylistDialog(BuildContext context) async {
    TextEditingController playlistNameController = TextEditingController();

    await showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text("Playlist Name"),
          content: TextField(
            controller: playlistNameController,
            decoration: InputDecoration(hintText: "name"),
          ),
          actions: [
            TextButton(
              child: Text(
                "Cancel",
              ),
              onPressed: () => Navigator.pop(dialogContext),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                String playlistName = playlistNameController.text.trim();
                if (playlistName.isNotEmpty) {
                  context.read<PlayListCubit>().addPlaylist(
                        PlaylistModelHive(
                          id: DateTime.now().microsecondsSinceEpoch,
                          name: playlistName,
                          songList: [],
                        ),
                      );
                  Navigator.pop(dialogContext);
                }
              },
              child: Text(
                "Create",
              ),
            ),
          ],
        );
      },
    );
  }
}
