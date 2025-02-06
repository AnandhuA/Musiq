import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:musiq/core/colors.dart';
import 'package:musiq/core/global_variables.dart';
import 'package:musiq/core/helper_funtions.dart';
import 'package:musiq/data/hive_funtions/liked_songs_repo.dart';
import 'package:musiq/models/song_model/song.dart';
import 'package:musiq/presentation/commanWidgets/dismissible_funtion.dart';
import 'package:musiq/presentation/commanWidgets/empty_screen.dart';
import 'package:musiq/presentation/screens/player_screen/bottomPlayer/bottom_player.dart';
import 'package:musiq/presentation/screens/player_screen/player_screen.dart';
import 'package:musiq/presentation/commanWidgets/bottom_sheet.dart';

class LikedSongsList extends StatelessWidget {
  const LikedSongsList({super.key});

  Future<List<Song>> _fetchLikedSongs() async {
    return await LikedSongsRepo.fetchLikedSong() ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Liked Songs")),
      body: Stack(
        children: [
          FutureBuilder<List<Song>>(
            future: _fetchLikedSongs(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return EmptyScreen(
                  text1: "wait",
                  size1: 15,
                  text2: "Liked songs",
                  size2: 20,
                  text3: "loading",
                  size3: 20,
                  isLoading: true,
                );
              }
              if (snapshot.hasError) {
                return EmptyScreen(
                  text1: "show",
                  size1: 15,
                  text2: "Nothing",
                  size2: 20,
                  text3: "Error",
                  size3: 20,
                );
              }
              if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return EmptyScreen(
                  text1: "show",
                  size1: 15,
                  text2: "Nothing",
                  size2: 20,
                  text3: "Songs",
                  size3: 20,
                );
              }

              final likedSongs = snapshot.data!;

              return ListView.builder(
                padding: const EdgeInsets.only(bottom: 100),
                itemCount: likedSongs.length,
                itemBuilder: (context, index) {
                  final Song song = likedSongs[index];
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
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(Icons.delete, color: Colors.white),
                          Icon(Icons.delete, color: Colors.white),
                        ],
                      ),
                    ),
                    child: ListTile(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PlayerScreen(
                            songs: likedSongs,
                            initialIndex: index,
                          ),
                        ),
                      ),
                      trailing: SongOptionsBottomSheet(song: song),
                      leading: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: CachedNetworkImageProvider(
                              song.image?.last.imageUrl ?? errorImage(),
                            ),
                            fit: BoxFit.fill,
                          ),
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      title: Text(
                        song.name ?? "No Title",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      subtitle: Text(
                        song.label ?? "No Label",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  );
                },
              );
            },
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
}
