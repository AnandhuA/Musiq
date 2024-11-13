import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:musiq/core/helper_funtions.dart';
import 'package:musiq/models/playlist_model/playlist_model.dart';
import 'package:musiq/presentation/commanWidgets/empty_screen.dart';
import 'package:musiq/presentation/screens/player_screen/player_screen.dart';

class ViewPlaylistScreen extends StatelessWidget {
  final PlaylistModelHive model;
  const ViewPlaylistScreen({
    super.key,
    required this.model,
  });

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
        title: Text(model.name),
      ),
      body: model.songList.isNotEmpty
          ? ListView.builder(
              itemCount: model.songList.length,
              itemBuilder: (context, index) {
                final song = model.songList[index];
                return ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PlayerScreen(
                            songs: model.songList,
                            initialIndex: index,
                          ),
                        ));
                  },
                  leading: CachedNetworkImage(
                    imageUrl: song.image?.last.imageUrl ?? errorImage(),
                    placeholder: (context, url) => songImagePlaceholder(),
                    errorWidget: (context, url, error) =>
                        songImagePlaceholder(),
                  ),
                  title: Text(song.name ?? "Nothig"),
                  subtitle: Text(song.label ?? "No"),
                );
              },
            )
          : emptyScreen(
              context: context,
              text1: "show",
              size1: 15,
              text2: "Nothing",
              size2: 20,
              text3: "AddSongs",
              size3: 20,
            ),
    );
  }
}
