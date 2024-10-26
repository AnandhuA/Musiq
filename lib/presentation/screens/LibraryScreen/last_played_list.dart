import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:musiq/core/global_variables.dart';
import 'package:musiq/core/helper_funtions.dart';
import 'package:musiq/data/hive_funtion.dart';
import 'package:musiq/models/song_model/song.dart';
import 'package:musiq/presentation/commanWidgets/empty_screen.dart';
import 'package:musiq/presentation/commanWidgets/favorite_icon.dart';
import 'package:musiq/presentation/screens/player_screen/bottomPlayer/bottom_player.dart';
import 'package:musiq/presentation/screens/player_screen/player_screen.dart';

class LastPlayedList extends StatefulWidget {
  LastPlayedList({super.key});

  @override
  State<LastPlayedList> createState() => _LastPlayedListState();
}

class _LastPlayedListState extends State<LastPlayedList> {
  final TextEditingController searchController = TextEditingController();
  List<Song> lastplayed = [];
  @override
  void initState() {
    featchLastplayed();
    super.initState();
  }

  featchLastplayed() async {
    lastplayed = await LastPlayedRepo.fetchLastPlayed();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back_ios_new_sharp)),
          title: Text("Last Played"),
          actions: [
            IconButton(
                onPressed: () async {
                  await LastPlayedRepo.clearLastPlayedSongs();
                  setState(() {
                    lastplayed = [];
                  });
                },
                icon: Icon(Icons.clear_all_sharp))
          ],
        ),
        body: Stack(
          children: [
            lastplayed.isEmpty
                ? emptyScreen(
                    context: context,
                    text1: "show",
                    size1: 15,
                    text2: "Nothing",
                    size2: 20,
                    text3: "Songs",
                    size3: 20,
                  )
                : ListView.builder(
                    padding: EdgeInsets.only(bottom: 100),
                    itemCount: lastplayed.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PlayerScreen(
                              songs: lastplayed,
                              initialIndex: index,
                            ),
                          ),
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            FavoriteIcon(
                              song: lastplayed[index],
                            ),
                            IconButton(
                                onPressed: () {}, icon: Icon(Icons.more_vert)),
                          ],
                        ),
                        leading: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: CachedNetworkImageProvider(
                                lastplayed[index].image?.last.imageUrl ??
                                    errorImage(),
                              ),
                              fit: BoxFit.fill,
                            ),
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        title: Text(
                          lastplayed[index].name ?? "No",
                          maxLines: 1,
                        ),
                        subtitle: Text(
                          lastplayed[index].label ?? "No",
                          maxLines: 1,
                        ),
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
        ));
  }
}
