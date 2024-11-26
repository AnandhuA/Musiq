import 'package:flutter/material.dart';
import 'package:musiq/core/colors.dart';
import 'package:musiq/core/global_variables.dart';
import 'package:musiq/core/helper_funtions.dart';
import 'package:musiq/core/sized.dart';
import 'package:musiq/models/playlist_model_hive/playlist_model.dart';
import 'package:musiq/presentation/screens/LibraryScreen/playlist.dart/view_playlist_screen.dart';

class HomepagePlaylistWidget extends StatelessWidget {
  final List<PlaylistModelHive> playlist;
  const HomepagePlaylistWidget({super.key, required this.playlist});

  @override
  Widget build(BuildContext context) {
    return playlist.isNotEmpty
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                " My PlayList",
                style: TextStyle(
                  fontSize: 20,
                  letterSpacing: 2,
                  fontWeight: FontWeight.w500,
                  color: AppColors.colorList[AppGlobals().colorIndex],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 14),
                height: 150,
                child: GridView.builder(
                  scrollDirection: Axis.horizontal,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 5,
                    crossAxisSpacing: 5,
                    childAspectRatio: 0.51,
                  ),
                  itemCount: playlist.length,
                  itemBuilder: (context, index) {
                    final iteam = playlist[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ViewPlaylistScreen(
                                model: iteam,
                              ),
                            ));
                      },
                      child: GridItem(
                        image: playlistCover(playlist: iteam),
                        title: iteam.name,
                        numberOfSongs: "${iteam.songList.length}",
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

class GridItem extends StatelessWidget {
  final Widget image;
  final String title;
  final String numberOfSongs;

  const GridItem(
      {Key? key,
      required this.image,
      required this.title,
      required this.numberOfSongs})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          image,
          AppSpacing.width10,
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  "$numberOfSongs-songs",
                  style: TextStyle(color: AppColors.grey, fontSize: 14),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
