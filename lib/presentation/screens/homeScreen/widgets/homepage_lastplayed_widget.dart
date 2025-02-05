import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:musiq/core/colors.dart';
import 'package:musiq/core/global_variables.dart';
import 'package:musiq/core/helper_funtions.dart';
import 'package:musiq/core/sized.dart';
import 'package:musiq/models/song_model/song.dart';
import 'package:musiq/presentation/commanWidgets/bottom_sheet.dart';
import 'package:musiq/presentation/screens/player_screen/player_screen.dart';

class HomepageLastplayedWidget extends StatelessWidget {
  final List<Song> songList;
  const HomepageLastplayedWidget({
    super.key,
    required this.songList,
  });

  @override
  Widget build(BuildContext context) {
    final List<Song> limitedSongList = songList.take(18).toList();
    return limitedSongList.isNotEmpty
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
                  itemCount: ((limitedSongList.length + 2) / 3).floor(),
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
                        0,
                      ),
                      child: Column(
                        children: List.generate(3, (itemIndex) {
                          final index = pageIndex * 3 + itemIndex;
                          if (index >= limitedSongList.length) {
                            return SizedBox();
                          }
                          final Song song = limitedSongList[index];
                          return Container(
                            child: ListTile(
                              leading: ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                child: CachedNetworkImage(
                                  imageUrl: limitedSongList[index]
                                          .image
                                          ?.last
                                          .imageUrl ??
                                      errorImage(),
                                  placeholder: (context, url) {
                                    // Placeholder logic
                                    return limitedSongList[index].type ==
                                            "Artist"
                                        ? artistImagePlaceholder()
                                        : limitedSongList[index].type == "album"
                                            ? albumImagePlaceholder()
                                            : songImagePlaceholder();
                                  },
                                  errorWidget: (context, url, error) {
                                    // Error widget logic
                                    return limitedSongList[index].type ==
                                            "Artist"
                                        ? artistImagePlaceholder()
                                        : limitedSongList[index].type == "album"
                                            ? albumImagePlaceholder()
                                            : songImagePlaceholder();
                                  },
                                ),
                              ),
                              title: Text(
                                limitedSongList[index].name ?? "NO",
                                maxLines: 1,
                              ),
                              subtitle: Text(
                                limitedSongList[index].album?.name ?? "No",
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
                              trailing: SongOptionsBottomSheet(song: song),
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
