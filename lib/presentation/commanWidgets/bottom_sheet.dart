import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musiq/bloc/favorite_bloc/favorite_bloc.dart';
import 'package:musiq/bloc/playlist/play_list_cubit.dart';
import 'package:musiq/core/colors.dart';
import 'package:musiq/core/global_variables.dart';
import 'package:musiq/core/helper_funtions.dart';
import 'package:musiq/models/song_model/song.dart';
import 'package:musiq/presentation/commanWidgets/favorite_icon.dart';
import 'package:musiq/presentation/commanWidgets/snack_bar.dart';

class SongOptionsBottomSheet extends StatelessWidget {
  final dynamic song;

  const SongOptionsBottomSheet({
    Key? key,
    required this.song,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final audioHandler = AppGlobals().audioHandler;

    return GestureDetector(
      onTap: () => _showOptionsBottomSheet(context, audioHandler),
      child: const Icon(Icons.more_vert_sharp),
    );
  }

//---------song more option------------
  void _showOptionsBottomSheet(
      BuildContext context, AudioHandler audioHandler) {
    final theme = Theme.of(context);
    showModalBottomSheet(
      backgroundColor: theme.brightness == Brightness.dark
          ? AppColors.black
          : AppColors.white,
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.wrap_text),
              title: const Text('Add to Queue'),
              onTap: () {
                _dismissKeyboard(context);
                _addToQueue(context, audioHandler);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: FavoriteIcon(song: song),
              title: Text("Favorite"),
              onTap: () {
                _dismissKeyboard(context);
                context.read<FavoriteBloc>().add(AddFavoriteEvent(song: song));
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.playlist_add),
              title: const Text('Add to Playlist'),
              onTap: () {
                _dismissKeyboard(context);
                Navigator.pop(context);
                showPlaylistSelectionBottomSheet(context: context, song: song);
              },
            ),
          ],
        );
      },
    );
  }

  void _addToQueue(BuildContext context, AudioHandler audioHandler) {
    if (AppGlobals().lastPlayedSongNotifier.value.isNotEmpty) {
      final audioHandler = AppGlobals().audioHandler;
      final mediaItem = MediaItem(
        id: song.downloadUrl?.last.link ?? "",
        album: song.album?.name ?? "No Album",
        title: song.label ?? "No Title",
        displayTitle: song.name ?? "",
        artUri: Uri.parse(song.image?.last.imageUrl ?? errorImage()),
      );

      audioHandler.addToQueue(mediaItem: mediaItem, song: song);
      customSnackbar(
        context: context,
        message: "${song.name} added to queue",
        bgColor: AppColors.white,
        textColor: AppColors.black,
        duration: const Duration(seconds: 5),
      );
    }
  }

//---------playlist bottom sheet-------------

  void _dismissKeyboard(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }
}

void showPlaylistSelectionBottomSheet({
  required BuildContext context,
  required Song song,
}) {
  final playListCubit = context.read<PlayListCubit>();
  playListCubit.featchPlayList();
  final theme = Theme.of(context);

  showModalBottomSheet(
    context: context,
    backgroundColor:
        theme.brightness == Brightness.dark ? AppColors.black : AppColors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (context) {
      return BlocBuilder<PlayListCubit, PlayListState>(
        builder: (context, state) {
          if (state is PlayListLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is FeatchPlayListSuccessState) {
            final playlists = state.playlistList;

            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    "Choose Playlist",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                Divider(color: AppColors.grey),
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: playlists.length,
                    itemBuilder: (context, index) {
                      final playlist = playlists[index];
                      return ListTile(
                        leading: playlist.imagePath == null
                            ? playlist.songList.isEmpty
                                ? CircleAvatar(
                                    backgroundColor: AppColors
                                        .colorList[AppGlobals().colorIndex],
                                    radius: 30,
                                    child: Text(playlist.name[0]),
                                  )
                                : playlistCover(playlist: playlist)
                            : SizedBox(),
                        title: Text(playlist.name),
                         subtitle: Text("${playlist.songList.length}-Songs"),
                        onTap: () {
                          context.read<PlayListCubit>().addSongToPlayList(
                                playlistModel: playlist,
                                songModel: song,
                              );
                          Navigator.pop(context);
                          customSnackbar(
                            context: context,
                            message: "${song.name} added to ${playlist.name}",
                            bgColor: AppColors.white,
                            textColor: AppColors.black,
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            );
          } else {
            return const Center(child: Text("No playlists available"));
          }
        },
      );
    },
  );
}

