import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:musiq/bloc/playlist/play_list_cubit.dart';
import 'package:musiq/core/colors.dart';
import 'package:musiq/core/global_variables.dart';
import 'package:musiq/core/helper_funtions.dart';
import 'package:musiq/core/sized.dart';
import 'package:musiq/models/playlist_model_hive/playlist_model.dart';
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
                      EmptyScreen(
                        text1: "wait",
                        size1: 15,
                        text2: "playList",
                        size2: 20,
                        text3: "loading",
                        size3: 20,
                        isLoading: true,
                      );
                    } else if (state is FetchPlayListSuccessState) {
                      return state.playlistList.isNotEmpty
                          ? ListView.separated(
                              separatorBuilder: (context, index) =>
                                  AppSpacing.height10,
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
                                            model: playlist,
                                          ),
                                        ));
                                  },
                                  onLongPress: () async {
                                    bool deleteConfirmed =
                                        await showDeleteConfirmationDialog(
                                            context, playlist.name);

                                    if (deleteConfirmed) {
                                      context
                                          .read<PlayListCubit>()
                                          .deletePlaylist(playlist: playlist);
                                      Fluttertoast.showToast(
                                          msg:
                                              "Playlist '${playlist.name}' deleted.");
                                    }
                                  },
                                  leading: playlist.imagePath == null
                                      ? playlist.songList.isEmpty
                                          ? CircleAvatar(
                                              backgroundColor:
                                                  AppColors.colorList[
                                                      AppGlobals().colorIndex],
                                              radius: 30,
                                              child: Text(playlist.name[0]),
                                            )
                                          : playlistCover(playlist: playlist)
                                      : SizedBox(),
                                  title: Text(
                                    playlist.name,
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  subtitle:
                                      Text("${playlist.songList.length}-Songs"),
                                );
                              },
                            )
                          : EmptyScreen(
                              text1: "show",
                              size1: 15,
                              text2: "empty",
                              size2: 20,
                              text3: "Playlist",
                              size3: 20,
                            );
                    }
                    return EmptyScreen(
                      text1: "show",
                      size1: 15,
                      text2: "empty",
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

//-----------Delete Confirmation Dialog------------
  Future<bool> showDeleteConfirmationDialog(
      BuildContext context, String playlistName) async {
    return await showDialog<bool>(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Delete Playlist"),
              content: Text(
                "Are you sure you want to delete the playlist '$playlistName'?",
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                  child: Text("Cancel"),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                  child: Text("Delete"),
                ),
              ],
            );
          },
        ) ??
        false;
  }

  //-----------create new playlist pop up ------------
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
                          name: playlistName.toLowerCase(),
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
