import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:musiq/data/favorite_song_functions.dart';
import 'package:musiq/models/song_model.dart';
import 'package:musiq/presentation/commanWidgets/favorite_icon.dart';
import 'package:musiq/presentation/screens/player_screen/player_screen.dart';

class LastPlayedList extends StatefulWidget {
  LastPlayedList({super.key});

  @override
  State<LastPlayedList> createState() => _LastPlayedListState();
}

class _LastPlayedListState extends State<LastPlayedList> {
  final TextEditingController searchController = TextEditingController();
  List<SongModel> lastplayed = [];
  @override
  void initState() {
    featchLastplayed();
    super.initState();
  }

  featchLastplayed() async {
    lastplayed = await FavoriteSongRepo.fetchLastPlayed();
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
      ),
      body: lastplayed.isEmpty
          ? const Center(
              child: Text("No Songs"),
            )
          : ListView.builder(
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
                  trailing: FavoriteIcon(
                    song: lastplayed[index],
                  ),
                  leading: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: CachedNetworkImageProvider(
                          lastplayed[index].imageUrl,
                        ),
                        fit: BoxFit.fill,
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  title: Text(
                    lastplayed[index].title,
                    maxLines: 1,
                  ),
                  subtitle: Text(
                    lastplayed[index].album,
                    maxLines: 1,
                  ),
                );
              },
            ),
    );
  }
}