import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:musiq/core/colors.dart';
import 'package:musiq/core/global_variables.dart';
import 'package:musiq/core/sized.dart';
import 'package:musiq/models/album_model/album_model.dart';
import 'package:musiq/models/play_list_model/play_list_model.dart';
import 'package:musiq/models/song_model/song.dart';
import 'package:musiq/presentation/commanWidgets/empty_screen.dart';
import 'package:musiq/presentation/screens/player_screen/player_screen.dart';

class NewAlbumOrPlaylistScreen extends StatefulWidget {
  final PlayListModel? playListModel;
  final AlbumModel? albumModel;
  final String imageUrl;
  const NewAlbumOrPlaylistScreen({
    super.key,
    required this.albumModel,
    required this.playListModel,
    required this.imageUrl,
  });

  @override
  State<NewAlbumOrPlaylistScreen> createState() =>
      _NewAlbumOrPlaylistScreenState();
}

class _NewAlbumOrPlaylistScreenState extends State<NewAlbumOrPlaylistScreen> {
  late String title;
  late bool isPlayList;
  List<Song> songList = [];

  @override
  void initState() {
    super.initState();
    if (widget.playListModel != null) {
      isPlayList = true;
      title = widget.playListModel?.data?.name ?? "No Name";
      songList = widget.playListModel?.data?.songs ?? [];
    } else {
      isPlayList = false;
      title = widget.albumModel?.data?.name ?? "No Name";
      songList = widget.albumModel?.data?.songs ?? [];
    }
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
        title: Text(title),
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.symmetric(
              horizontal: isDesktop(context) ? 30 : 0,
            ),
            child: Row(
              children: [
                Container(
                  width: isMobile(context) ? 220 : 280,
                  height: isMobile(context) ? 200 : 250,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: CachedNetworkImage(
                      imageUrl: widget.imageUrl,
                      fit: BoxFit.cover,
                      errorWidget: (context, url, error) =>
                          Image.asset("assets/images/album.png"),
                      placeholder: (context, url) =>
                          Image.asset("assets/images/album.png"),
                    ),
                  ),
                ),
                AppSpacing.width20,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 5,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: AppColors.colorList[AppGlobals().colorIndex],
                        ),
                      ),
                      Text(
                        isPlayList
                            ? "${widget.playListModel?.data?.songs?.length}-songs"
                            : "${widget.albumModel?.data?.songs?.length}-songs",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 5,
                      ),
                      Text(
                        isPlayList
                            ? widget.playListModel?.data?.language ?? "null"
                            : widget.albumModel?.data?.language ?? "null",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 5,
                      ),
                      Text(
                        isPlayList
                            ? widget.playListModel?.data?.description ?? "null"
                            : widget.albumModel?.data?.name ?? "null",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 5,
                      ),
                      AppSpacing.height10,
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () async {
                              // if (!_addToLibrary) {
                              //   await AddToLibrary.addLibraryItem(
                              //     libraryModel: widget.libraryModel,
                              //   );
                              //   customSnackbar(
                              //     context: context,
                              //     message: "Add to Library",
                              //     bgColor: Theme.of(context).brightness ==
                              //             Brightness.dark
                              //         ? AppColors.white
                              //         : AppColors.black,
                              //     textColor: Theme.of(context).brightness ==
                              //             Brightness.dark
                              //         ? AppColors.black
                              //         : AppColors.white,
                              //   );
                              // } else {
                              //   await AddToLibrary.deleteLibraryItem(
                              //     id: widget.libraryModel.id,
                              //     type: widget.libraryModel.type,
                              //   );
                              //   customSnackbar(
                              //     context: context,
                              //     message: "removed from the library",
                              //     bgColor: Theme.of(context).brightness ==
                              //             Brightness.dark
                              //         ? AppColors.white
                              //         : AppColors.black,
                              //     textColor: Theme.of(context).brightness ==
                              //             Brightness.dark
                              //         ? AppColors.black
                              //         : AppColors.white,
                              //   );
                              // }
                              // setState(() {
                              //   _addToLibrary = !_addToLibrary;
                              // });
                            },
                            child: Container(
                              width: 34,
                              height: 34,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: AppColors
                                      .colorList[AppGlobals().colorIndex],
                                  width: 2.0,
                                ),
                              ),
                              child: Center(
                                child: Icon(
                                  // _addToLibrary ? Icons.check :
                                  Icons.add,
                                  size: 20,
                                ),
                              ),
                            ),
                          ),
                          Spacer(),
                          GestureDetector(
                            onTap: () {
                              songList.isNotEmpty
                                  ? Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => PlayerScreen(
                                          songs: songList,
                                        ),
                                      ))
                                  : null;
                            },
                            child: CircleAvatar(
                              backgroundColor:
                                  AppColors.colorList[AppGlobals().colorIndex],
                              radius: 28,
                              child: Center(
                                child: Icon(
                                  Icons.play_arrow_sharp,
                                  size: 35,
                                  color: theme.brightness == Brightness.dark
                                      ? AppColors.black
                                      : AppColors.white,
                                ),
                              ),
                            ),
                          ),
                          AppSpacing.width20
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          AppSpacing.height30,
          songList.isEmpty
              ? emptyScreen(
                  context: context,
                  text1: "show",
                  size1: 15,
                  text2: "Nothing",
                  size2: 20,
                  text3: "Songs",
                  size3: 20,
                )
              : Expanded(
                  child: ListView.builder(
                    itemCount: songList.length,
                    itemBuilder: (context, index) {
                      final song = songList[index];

                      return ListTile(
                        onTap: () {
                          log("song link ---${songList[index].downloadUrl?.last.link}");
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PlayerScreen(
                                  songs: songList,
                                  initialIndex: index,
                                ),
                              ));
                        },
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: CachedNetworkImage(
                            imageUrl: song.image?.last.imageUrl ?? "",
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
                          song.name ?? "no",
                          maxLines: 1,
                        ),
                        subtitle: Text(
                          song.label ?? "no",
                          maxLines: 1,
                        ),
                        // trailing: FavoriteIcon(song: song),
                      );
                    },
                  ),
                ),
        ],
      ),
    );
  }
}
