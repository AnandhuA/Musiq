import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:musiq/core/colors.dart';
import 'package:musiq/core/sized.dart';
import 'package:musiq/data/add_to_library_funtions.dart';
import 'package:musiq/main.dart';
import 'package:musiq/models/library_model.dart';
import 'package:musiq/models/song_model.dart';
import 'package:musiq/presentation/commanWidgets/favorite_icon.dart';
import 'package:musiq/presentation/commanWidgets/snack_bar.dart';
import 'package:musiq/presentation/screens/player_screen/player_screen.dart';

class AlbumOrPlaylistScreen extends StatefulWidget {
  final List<SongModel> songModel;
  final String? imageUrl;
  final String title;
  final LibraryModel libraryModel;
  const AlbumOrPlaylistScreen({
    super.key,
    required this.songModel,
    this.imageUrl,
    required this.title,
    required this.libraryModel,
  });

  @override
  State<AlbumOrPlaylistScreen> createState() => _AlbumOrPlaylistScreenState();
}

class _AlbumOrPlaylistScreenState extends State<AlbumOrPlaylistScreen> {
  bool _addToLibrary = false;

  @override
  void initState() {
    super.initState();
    _checkAddToLibery();
  }

  _checkAddToLibery() async {
    _addToLibrary = await AddToLibrary.checkLibraryItemExists(
        id: widget.libraryModel.id, type: widget.libraryModel.type);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
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
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.all(10),
            padding:
                EdgeInsets.symmetric(horizontal: isDesktop(context) ? 30 : 0),
            child: Row(
              children: [
                Container(
                  width: isMobile(context) ? 220 : 280,
                  height: isMobile(context) ? 200 : 250,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: CachedNetworkImage(
                      imageUrl:
                          widget.imageUrl ?? widget.songModel.first.imageUrl,
                      fit: BoxFit.cover,
                      placeholder: (context, url) =>
                          widget.songModel.first.type == "Artist"
                              ? Image.asset("assets/images/artist.png")
                              : widget.songModel.first.type == "album"
                                  ? Image.asset("assets/images/album.png")
                                  : Image.asset("assets/images/song.png"),
                      errorWidget: (context, url, error) =>
                          widget.songModel.first.type == "Artist"
                              ? Image.asset("assets/images/artist.png")
                              : widget.songModel.first.type == "album"
                                  ? Image.asset("assets/images/album.png")
                                  : Image.asset("assets/images/song.png"),
                    ),
                  ),
                ),
                constWidth20,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.title,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 5,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: colorList[colorIndex],
                        ),
                      ),
                      Text(
                        "${widget.songModel.length}-songs",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 5,
                      ),
                      widget.songModel.isNotEmpty
                          ? Text(
                              widget.songModel.first.language,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 5,
                            )
                          : SizedBox(),
                      widget.songModel.isNotEmpty
                          ? Text(
                              widget.songModel.first.albumArtist,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 5,
                            )
                          : SizedBox(),
                      constHeight10,
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () async {
                              if (!_addToLibrary) {
                                await AddToLibrary.addLibraryItem(
                                  libraryModel: widget.libraryModel,
                                );
                                customSnackbar(
                                  context: context,
                                  message: "Add to Library",
                                  bgColor: Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? white
                                      : black,
                                  textColor: Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? black
                                      : white,
                                );
                              } else {
                                await AddToLibrary.deleteLibraryItem(
                                  id: widget.libraryModel.id,
                                  type: widget.libraryModel.type,
                                );
                                customSnackbar(
                                  context: context,
                                  message: "removed from the library",
                                  bgColor: Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? white
                                      : black,
                                  textColor: Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? black
                                      : white,
                                );
                              }
                              setState(() {
                                _addToLibrary = !_addToLibrary;
                              });
                            },
                            child: Container(
                              width: 34,
                              height: 34,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: colorList[colorIndex],
                                  width: 2.0,
                                ),
                              ),
                              child: Center(
                                child: Icon(
                                  _addToLibrary ? Icons.check : Icons.add,
                                  size: 20,
                                ),
                              ),
                            ),
                          ),
                          Spacer(),
                          GestureDetector(
                            onTap: () {
                              widget.songModel.isNotEmpty
                                  ? Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => PlayerScreen(
                                          songs: widget.songModel,
                                        ),
                                      ))
                                  : null;
                            },
                            child: CircleAvatar(
                              backgroundColor: colorList[colorIndex],
                              radius: 28,
                              child: Center(
                                child: Icon(
                                  Icons.play_arrow_sharp,
                                  size: 35,
                                  color: theme.brightness == Brightness.dark
                                      ? Colors.black
                                      : Colors.white,
                                ),
                              ),
                            ),
                          ),
                          constWidth20
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          constHeight30,
          Expanded(
            child: ListView.builder(
              itemCount: widget.songModel.length,
              itemBuilder: (context, index) {
                final song = widget.songModel[index];
                return ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PlayerScreen(
                            songs: widget.songModel,
                            initialIndex: index,
                          ),
                        ));
                  },
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: CachedNetworkImage(
                      imageUrl: song.imageUrl,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => song.type == "Artist"
                          ? Image.asset("assets/images/artist.png")
                          : song.type == "album"
                              ? Image.asset("assets/images/album.png")
                              : Image.asset("assets/images/song.png"),
                      errorWidget: (context, url, error) =>
                          song.type == "Artist"
                              ? Image.asset("assets/images/artist.png")
                              : song.type == "album"
                                  ? Image.asset("assets/images/album.png")
                                  : Image.asset("assets/images/song.png"),
                    ),
                  ),
                  title: Text(
                    song.title,
                    maxLines: 1,
                  ),
                  subtitle: Text(
                    song.subtitle,
                    maxLines: 1,
                  ),
                  trailing: FavoriteIcon(song: song),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
