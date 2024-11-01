import 'package:audio_service/audio_service.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:musiq/core/colors.dart';
import 'package:musiq/core/global_variables.dart';
import 'package:musiq/core/helper_funtions.dart';
import 'package:musiq/core/sized.dart';
import 'package:musiq/models/song_model/song.dart';
import 'package:musiq/presentation/commanWidgets/favorite_icon.dart';
import 'package:musiq/presentation/commanWidgets/snack_bar.dart';
import 'package:musiq/presentation/screens/player_screen/player_screen.dart';

class HomepageLastplayedWidget extends StatelessWidget {
  final List<Song> songList;
  const HomepageLastplayedWidget({
    super.key,
    required this.songList,
  });

  @override
  Widget build(BuildContext context) {
    return songList.isNotEmpty
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                " Last Played",
                style: TextStyle(
                  fontSize: 20,
                  letterSpacing: 2,
                  fontWeight: FontWeight.w500,
                  color: AppColors.colorList[AppGlobals().colorIndex],
                ),
              ),
              Container(
                height: 230,
                child: PageView.builder(
                  itemCount: ((songList.length + 2) / 3).floor(),
                  pageSnapping: true,
                  controller: PageController(
                    viewportFraction: 0.9,
                  ),
                  itemBuilder: (context, pageIndex) {
                    return Transform.translate(
                      offset: Offset(
                          isMobile(context)
                              ? -22
                              : isTablet(context)
                                  ? -38
                                  : -70,
                          0),
                      child: Column(
                        children: List.generate(3, (itemIndex) {
                          final index = pageIndex * 3 + itemIndex;
                          if (index >= songList.length) {
                            return SizedBox();
                          }
                          final Song song = songList[index];
                          return Container(
                            child: ListTile(
                              leading: ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                child: CachedNetworkImage(
                                  imageUrl:
                                      songList[index].image?.last.imageUrl ??
                                          errorImage(),
                                  placeholder: (context, url) {
                                    // Placeholder logic
                                    return songList[index].type == "Artist"
                                        ? Image.asset(
                                            "assets/images/artist.png")
                                        : songList[index].type == "album"
                                            ? Image.asset(
                                                "assets/images/album.png")
                                            : Image.asset(
                                                "assets/images/song.png");
                                  },
                                  errorWidget: (context, url, error) {
                                    // Error widget logic
                                    return songList[index].type == "Artist"
                                        ? Image.asset(
                                            "assets/images/artist.png")
                                        : songList[index].type == "album"
                                            ? Image.asset(
                                                "assets/images/album.png")
                                            : Image.asset(
                                                "assets/images/song.png");
                                  },
                                ),
                              ),
                              title: Text(
                                songList[index].name ?? "NO",
                                maxLines: 1,
                              ),
                              subtitle: Text(
                                songList[index].album?.name ?? "No",
                                maxLines: 1,
                              ),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => PlayerScreen(
                                      songs: songList,
                                      initialIndex: index,
                                    ),
                                  ),
                                );
                              },
                              trailing: PopupMenuButton<int>(
                                  icon: Icon(Icons.more_vert_sharp),
                                  onSelected: (value) {
                                    // Handle selected menu action
                                    final audioHandler =
                                        AppGlobals().audioHandler;

                                    switch (value) {
                                      case 0:
                                        if (AppGlobals()
                                            .lastPlayedSongNotifier
                                            .value
                                            .isNotEmpty) {
                                          final mediaItem = MediaItem(
                                            id: song.downloadUrl?.last.link ??
                                                "",
                                            album: song.album?.name ?? "No ",
                                            title: song.label ?? "No ",
                                            displayTitle: song.name ?? "",
                                            artUri: Uri.parse(
                                                song.image?.last.imageUrl ??
                                                    errorImage()),
                                          );

                                          audioHandler.addToQueue(
                                              mediaItem: mediaItem, song: song);
                                          customSnackbar(
                                              context: context,
                                              message:
                                                  "${song.name} added to queue",
                                              bgColor: AppColors.white,
                                              textColor: AppColors.black,
                                              duration: Duration(seconds: 5));
                                        }

                                        break;
                                      case 1:
                                        // Handle "Add to Playlist" action
                                        break;
                                      case 2:
                                        // Handle "Share" action
                                        break;
                                    }
                                  },
                                  itemBuilder: (context) => [
                                        PopupMenuItem(
                                          value: 0,
                                          child:  Row(
                                            children: [
                                              Icon(Icons.wrap_text),
                                              Text('Add to Queue'),
                                            ],
                                          ),
                                        ),
                                        PopupMenuItem(
                                          value: 1,
                                          child: Row(
                                            children: [
                                              FavoriteIcon(song: song),
                                              Text("Favorite")
                                            ],
                                          ),
                                        ),
                                        PopupMenuItem(
                                          value: 2,
                                          child: Text('Add to Playlist'),
                                        ),
                                      ]),
                            ),
                          );
                        }),
                      ),
                    );
                  },
                ),
              ),
            ],
          )
        : SizedBox();
  }
}
