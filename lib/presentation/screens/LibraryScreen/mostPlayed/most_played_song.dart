import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:musiq/core/helper_funtions.dart';
import 'package:musiq/core/sized.dart';
import 'package:musiq/data/hive_funtions/history_repo.dart';
import 'package:musiq/models/song_model/song.dart';
import 'package:musiq/presentation/commanWidgets/empty_screen.dart';

class MostPlayedSong extends StatelessWidget {
  const MostPlayedSong({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios_new_sharp),
        ),
        title: const Text("Most Played Song"),
      ),
      body: FutureBuilder<Song?>(
        future: HistoryRepo.findMostPlayedSong(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return EmptyScreen(
              isLoading: true,
              text1: "Wait",
              size1: 15,
              text2: "Song",
              size2: 20,
              text3: "Loading",
              size3: 20,
            );
          } else if (snapshot.hasError) {
            return EmptyScreen(
              text1: "show",
              size1: 15,
              text2: "Nothing",
              size2: 20,
              text3: "${snapshot.error}",
              size3: 20,
            );
          } else if (!snapshot.hasData || snapshot.data == null) {
            return EmptyScreen(
              text1: "show",
              size1: 15,
              text2: "Nothing",
              size2: 20,
              text3: "Songs",
              size3: 20,
            );
          }

          // Get the most played song
          final mostPlayedSong = snapshot.data!;
          return Container(
            margin: EdgeInsets.all(20),
            height: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.grey.withOpacity(0.3),
            ),
            child: Row(
              children: [
                Container(
                  margin: EdgeInsets.all(10),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: CachedNetworkImage(
                      imageUrl:
                          mostPlayedSong.image?.last.imageUrl ?? errorImage(),
                      placeholder: (context, url) => songImagePlaceholder(),
                    ),
                  ),
                ),
                AppSpacing.width10,
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        overflow: TextOverflow.fade,
                        mostPlayedSong.name ?? "Nothing",
                        style: TextStyle(fontSize: 20),
                      ),
                      AppSpacing.height10,
                      Text(
                        overflow: TextOverflow.ellipsis,
                        mostPlayedSong.album?.name ?? "Nothing",
                        style: TextStyle(fontSize: 18),
                      ),
                      AppSpacing.height10,
                      Text(
                        "Count : ${mostPlayedSong.localPlayCount}",
                        style: TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
