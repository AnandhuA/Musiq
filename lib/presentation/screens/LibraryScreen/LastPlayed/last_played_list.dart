import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:musiq/core/colors.dart';
import 'package:musiq/core/global_variables.dart';
import 'package:musiq/core/helper_funtions.dart';
import 'package:musiq/data/hive_funtions/last_played_repo.dart';
import 'package:musiq/models/song_model/song.dart';
import 'package:musiq/presentation/commanWidgets/dismissible_funtion.dart';
import 'package:musiq/presentation/commanWidgets/empty_screen.dart';
import 'package:musiq/presentation/commanWidgets/bottom_sheet.dart';
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
    FetchLastplayed();
    super.initState();
  }

  FetchLastplayed() async {
    lastplayed = await LastPlayedRepo.fetchLastPlayed() ?? [];
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
              ? EmptyScreen(
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
                    final Song song = lastplayed[index];
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
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PlayerScreen(
                              songs: lastplayed,
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
      ),
    );
  }
}
