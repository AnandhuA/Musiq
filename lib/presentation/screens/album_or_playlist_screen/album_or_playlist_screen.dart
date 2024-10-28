import 'dart:developer';

import 'package:audio_service/audio_service.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:musiq/core/colors.dart';
import 'package:musiq/core/global_variables.dart';
import 'package:musiq/core/helper_funtions.dart';
import 'package:musiq/core/sized.dart';
import 'package:musiq/models/album_model/album_model.dart';
import 'package:musiq/models/play_list_model/play_list_model.dart';
import 'package:musiq/models/song_model/song.dart';
import 'package:musiq/presentation/commanWidgets/empty_screen.dart';
import 'package:musiq/presentation/screens/artist/widgets/artist_horizontal_listview.dart';
import 'package:musiq/presentation/screens/player_screen/bottomPlayer/bottom_player.dart';
import 'package:musiq/presentation/screens/player_screen/player_screen.dart';

class AlbumOrPlaylistScreen extends StatefulWidget {
  final PlayListModel? playListModel;
  final AlbumModel? albumModel;
  final String imageUrl;
  const AlbumOrPlaylistScreen({
    super.key,
    required this.albumModel,
    required this.playListModel,
    required this.imageUrl,
  });

  @override
  State<AlbumOrPlaylistScreen> createState() => _AlbumOrPlaylistScreenState();
}

class _AlbumOrPlaylistScreenState extends State<AlbumOrPlaylistScreen> {
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
      body: Stack(
        children: [
          Column(
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
                              albumImagePlaceholder(),
                          placeholder: (context, url) =>
                              albumImagePlaceholder(),
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
                            maxLines: 2,
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color:
                                  AppColors.colorList[AppGlobals().colorIndex],
                            ),
                          ),
                          Text(
                            isPlayList
                                ? "${widget.playListModel?.data?.songs?.length}-songs"
                                : "${widget.albumModel?.data?.songs?.length}-songs",
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                          Text(
                            isPlayList
                                ? widget.playListModel?.data?.language ?? "null"
                                : widget.albumModel?.data?.language ?? "null",
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                          Text(
                            isPlayList
                                ? widget.playListModel?.data?.description ??
                                    "null"
                                : widget.albumModel?.data?.name ?? "null",
                            overflow: TextOverflow.ellipsis,
                            maxLines: 3,
                          ),
                          AppSpacing.height10,
                          Row(
                            children: [
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
                                  backgroundColor: AppColors
                                      .colorList[AppGlobals().colorIndex],
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
                        padding: EdgeInsets.only(bottom: 100),
                        itemCount: songList.length + (isPlayList ? 1 : 0),
                        itemBuilder: (context, index) {
                          if (isPlayList && index == songList.length) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "  Similar Artists",
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: AppColors
                                          .colorList[AppGlobals().colorIndex],
                                    ),
                                  ),
                                  ArtistHorizontalListview(
                                    dataList:
                                        widget.playListModel?.data?.artists ??
                                            [],
                                  ),
                                ],
                              ),
                            );
                          }
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
                                placeholder: (context, url) =>
                                    song.type == "Artist"
                                        ? artistImagePlaceholder()
                                        : song.type == "album"
                                            ? albumImagePlaceholder()
                                            : songImagePlaceholder(),
                                errorWidget: (context, url, error) =>
                                    song.type == "Artist"
                                        ? artistImagePlaceholder()
                                        : song.type == "album"
                                            ? albumImagePlaceholder()
                                            : songImagePlaceholder(),
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
                            trailing: PopupMenuButton<int>(
                              icon: Icon(Icons.more_vert_sharp),
                              onSelected: (value) {
                                // Handle selected menu action
                                final audioHandler = AppGlobals().audioHandler;

                                switch (value) {
                                  case 0:
                                    if (AppGlobals()
                                        .lastPlayedSongNotifier
                                        .value
                                        .isNotEmpty) {
                                      final mediaItem = MediaItem(
                                        id: song.downloadUrl?.last.link ?? "",
                                        album: song.album?.name ?? "No ",
                                        title: song.label ?? "No ",
                                        displayTitle: song.name ?? "",
                                        artUri: Uri.parse(
                                            song.image?.last.imageUrl ??
                                                errorImage()),
                                      );

                                      audioHandler.addToQueue(
                                          mediaItem: mediaItem, song: song);
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
                                  child: Text('Add to Queue'),
                                ),
                                PopupMenuItem(
                                  value: 1,
                                  child: Text('Add to Favorite'),
                                ),
                                PopupMenuItem(
                                  value: 2,
                                  child: Text('Add to Playlist'),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
            ],
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
