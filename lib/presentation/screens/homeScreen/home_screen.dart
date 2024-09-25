import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musiq/core/colors.dart';
import 'package:musiq/core/sized.dart';
import 'package:musiq/main.dart';
import 'package:musiq/bloc/home_screen_cubit/home_screen_cubit.dart';
import 'package:musiq/models/home_screen_model.dart';
import 'package:musiq/presentation/screens/album_or_playlist_screen/album_or_playlist_screen.dart';
import 'package:musiq/bloc/FeatchSong/featch_song_cubit.dart';
import 'package:musiq/presentation/screens/player_screen/player_screen.dart';
import 'package:musiq/bloc/ThemeCubit/theme_cubit.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        return Scaffold(
          body: BlocBuilder<HomeScreenCubit, HomeScreenState>(
            builder: (context, state) {
              if (state is HomeScreenLoaded) {
                final songList = getAllSongs(state.homeScreenModel);
                return SingleChildScrollView(
                  child: BlocListener<FeatchSongCubit, FeatchSongState>(
                    listener: (context, state) {
                      /// ----------- show loading ---------
                      if (state is FeatchSongLoading) {
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              backgroundColor: Colors.transparent,
                              content: Center(
                                child: CircularProgressIndicator(
                                  color: colorList[colorIndex],
                                ),
                              ),
                            );
                          },
                        );
                      } else if (state is FeatchSongLoaded) {
                        Navigator.pop(context); // for close loading
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  PlayerScreen(songs: state.songModel),
                            ));
                      } else if (state is FeatchAlbumOrPlayList) {
                        Navigator.pop(context); // for close loading
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AlbumOrPlaylistScreen(
                                songModel: state.songModel,
                                imageUrl: state.imageUrl,
                                title: state.title,
                                libraryModel: state.libraryModel,
                              ),
                            ));
                      }
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        constHeight10,
                        state.lastplayed.isNotEmpty
                            ? Text(
                                "  Last Played ",
                                style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    color: colorList[colorIndex]),
                              )
                            : SizedBox(),
                        state.lastplayed.isNotEmpty
                            ? Container(
                                height: 230,
                                child: PageView.builder(
                                  itemCount: ((state.lastplayed.length + 2) / 3)
                                      .floor(),
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
                                          0),
                                      child: Column(
                                        children: List.generate(3, (itemIndex) {
                                          final index =
                                              pageIndex * 3 + itemIndex;
                                          if (index >=
                                              state.lastplayed.length) {
                                            return SizedBox();
                                          }
                                          return Container(
                                            child: ListTile(
                                              leading: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                child: CachedNetworkImage(
                                                  imageUrl: state
                                                      .lastplayed[index]
                                                      .imageUrl,
                                                  placeholder: (context, url) {
                                                    // Placeholder logic
                                                    return state
                                                                .lastplayed[
                                                                    index]
                                                                .type ==
                                                            "Artist"
                                                        ? Image.asset(
                                                            "assets/images/artist.png")
                                                        : state
                                                                    .lastplayed[
                                                                        index]
                                                                    .type ==
                                                                "album"
                                                            ? Image.asset(
                                                                "assets/images/album.png")
                                                            : Image.asset(
                                                                "assets/images/song.png");
                                                  },
                                                  errorWidget:
                                                      (context, url, error) {
                                                    // Error widget logic
                                                    return state
                                                                .lastplayed[
                                                                    index]
                                                                .type ==
                                                            "Artist"
                                                        ? Image.asset(
                                                            "assets/images/artist.png")
                                                        : state
                                                                    .lastplayed[
                                                                        index]
                                                                    .type ==
                                                                "album"
                                                            ? Image.asset(
                                                                "assets/images/album.png")
                                                            : Image.asset(
                                                                "assets/images/song.png");
                                                  },
                                                ),
                                              ),
                                              title: Text(
                                                state.lastplayed[index].title,
                                                maxLines: 1,
                                              ),
                                              subtitle: Text(
                                                state.lastplayed[index].artist,
                                                maxLines: 1,
                                              ),
                                              onTap: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        PlayerScreen(
                                                      songs: state.lastplayed,
                                                      initialIndex: index,
                                                    ),
                                                  ),
                                                );
                                              },
                                              trailing: IconButton(
                                                  onPressed: () {},
                                                  icon: Icon(Icons.more_vert)),
                                            ),
                                          );
                                        }),
                                      ),
                                    );
                                  },
                                ),
                              )
                            : SizedBox(),
                        constHeight20,
                        Text(
                          " Trending songs",
                          style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: colorList[colorIndex]),
                        ),
                        constHeight20,
                        _SongList(
                          model: state.homeScreenModel.newTrending,
                          boderRadius: 10,
                        ),
                        Text(
                          " Playlist",
                          style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: colorList[colorIndex]),
                        ),
                        constHeight20,
                        _SongList(
                          model: state.homeScreenModel.charts,
                          boderRadius: 20,
                        ),
                        constHeight20,
                        _SongList(
                          model: state.homeScreenModel.topPlaylists,
                          boderRadius: 20,
                        ),
                        Text(
                          " Artist",
                          style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: colorList[colorIndex]),
                        ),
                        constHeight20,
                        _SongList(
                          model: state.homeScreenModel.artistRecos,
                          boderRadius: 100,
                        ),
//----------------------top played --------------------------------
                        songList.isNotEmpty
                            ? Text(
                                "  Top Played ",
                                style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    color: colorList[colorIndex]),
                              )
                            : SizedBox(),
                        songList.isNotEmpty
                            ? Container(
                                height: 230,
                                child: PageView.builder(
                                  itemCount:
                                      ((songList.length + 2) / 3).floor(),
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
                                          0),
                                      child: Column(
                                        children: List.generate(3, (itemIndex) {
                                          final index =
                                              pageIndex * 3 + itemIndex;
                                          if (index >= songList.length) {
                                            return SizedBox();
                                          }
                                          return Container(
                                            child: ListTile(
                                              leading: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                child: CachedNetworkImage(
                                                  imageUrl: songList[index]
                                                          .image ??
                                                      "https://static.vecteezy.com/system/resources/thumbnails/037/044/052/small_2x/ai-generated-studio-shot-of-black-headphones-over-music-note-explosion-background-with-empty-space-for-text-photo.jpg",
                                                  placeholder: (context, url) {
                                                    // Placeholder logic
                                                    return songList[index]
                                                                .type ==
                                                            "Artist"
                                                        ? Image.asset(
                                                            "assets/images/artist.png")
                                                        : songList[index]
                                                                    .type ==
                                                                "album"
                                                            ? Image.asset(
                                                                "assets/images/album.png")
                                                            : Image.asset(
                                                                "assets/images/song.png");
                                                  },
                                                  errorWidget:
                                                      (context, url, error) {
                                                    // Error widget logic
                                                    return songList[index]
                                                                .type ==
                                                            "Artist"
                                                        ? Image.asset(
                                                            "assets/images/artist.png")
                                                        : songList[index]
                                                                    .type ==
                                                                "album"
                                                            ? Image.asset(
                                                                "assets/images/album.png")
                                                            : Image.asset(
                                                                "assets/images/song.png");
                                                  },
                                                ),
                                              ),
                                              title: Text(
                                                songList[index].title,
                                                maxLines: 1,
                                              ),
                                              subtitle: Text(
                                                songList[index].subtitle,
                                                maxLines: 1,
                                              ),
                                              onTap: () {
                                                context
                                                    .read<FeatchSongCubit>()
                                                    .clickSong(
                                                        type: songList[index]
                                                                .type ??
                                                            "",
                                                        id: songList[index]
                                                                .id ??
                                                            "0",
                                                        imageUrl:
                                                            songList[index]
                                                                .image,
                                                        title: songList[index]
                                                            .title);
                                              },
                                              trailing: IconButton(
                                                  onPressed: () {},
                                                  icon: Icon(Icons.more_vert)),
                                            ),
                                          );
                                        }),
                                      ),
                                    );
                                  },
                                ),
                              )
                            : SizedBox(),

//--------------------------------------------------------------

                        Text(
                          " TagMixes",
                          style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: colorList[colorIndex]),
                        ),
                        constHeight20,
                        _SongList(
                          model: state.homeScreenModel.tagMixes,
                          boderRadius: 30,
                        ),

                        Text(
                          " Albums",
                          style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: colorList[colorIndex]),
                        ),
                        constHeight20,
                        _SongList(
                          model: state.homeScreenModel.newAlbums,
                          boderRadius: 10,
                        ),
                        constHeight20,
                        Text(
                          " BrowseDiscover",
                          style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: colorList[colorIndex]),
                        ),
                        constHeight20,
                        _SongList(
                          model: state.homeScreenModel.promoVxData122,
                          boderRadius: 20,
                        ),
                        constHeight10,
                        _SongList(
                          model: state.homeScreenModel.promoVxData113,
                          boderRadius: 20,
                        ),
                        constHeight10,
                        _SongList(
                          model: state.homeScreenModel.promoVxData117,
                          boderRadius: 20,
                        ),
                        constHeight10,
                        _SongList(
                          model: state.homeScreenModel.promoVxData116,
                          boderRadius: 20,
                        ),
                        constHeight10,
                        _SongList(
                          model: state.homeScreenModel.promoVxData118,
                          boderRadius: 20,
                        ),
                      ],
                    ),
                  ),
                );
              } else {
                return SizedBox(
                  child: Center(
                      child: CircularProgressIndicator(
                    color: colorList[colorIndex],
                  )),
                );
              }
            },
          ),
        );
      },
    );
  }
}

// ignore: must_be_immutable
class _SongList extends StatelessWidget {
  final List model;
  double boderRadius;
  _SongList({
    required this.model,
    required this.boderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: ListView.separated(
        separatorBuilder: (context, index) => SizedBox(width: 10),
        itemCount: model.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final data = model[index];

          return GestureDetector(
            onTap: () {
              log("Type: ${data.type}");
              log("ID: ${data.id}");
              log("Title: ${data.title}");
              // log("Subtitle: ${data.subtitle}");
              // log("Description: ${data.description}");
              // log("HeaderDesc: ${data.headerDesc}");
              // log("PermaUrl: ${data.permaUrl}");
              // log("Image: ${data.image}");
              // log("Language: ${data.language}");
              // log("Year: ${data.year}");
              // log("PlayCount: ${data.playCount}");
              // log("ExplicitContent: ${data.explicitContent}");
              // log("ListCount: ${data.listCount}");
              // log("ListType: ${data.listType}");
              // log("List: ${data.list.toString()}"); // Convert list to a string
              // log("MoreInfo: ${data.moreInfo}"); // Assuming moreInfo is a Map
              // log("ButtonTooltipInfo: ${data.buttonTooltipInfo}");
              if (data.type == "radio_station") {
                context.read<FeatchSongCubit>().feachArtistSong(
                      artistName: data.title,
                      imageUrl: data.image,
                      title: data.title,
                    );
              } else {
                context.read<FeatchSongCubit>().clickSong(
                    type: data.type ?? "",
                    id: data.id ?? "0",
                    imageUrl: data.image,
                    title: data.title);
              }
            },
            child: SizedBox(
              width: 180,
              child: Column(
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(boderRadius),
                      child: CachedNetworkImage(
                        imageUrl: data.image ??
                            "https://static.vecteezy.com/system/resources/thumbnails/037/044/052/small_2x/ai-generated-studio-shot-of-black-headphones-over-music-note-explosion-background-with-empty-space-for-text-photo.jpg",
                        fit: BoxFit.cover,
                        placeholder: (context, url) => data.type == "Artist"
                            ? Image.asset("assets/images/artist.png")
                            : data.type == "album"
                                ? Image.asset("assets/images/album.png")
                                : Image.asset("assets/images/song.png"),
                        errorWidget: (context, url, error) =>
                            data.type == "Artist"
                                ? Image.asset("assets/images/artist.png")
                                : data.type == "album"
                                    ? Image.asset("assets/images/album.png")
                                    : Image.asset("assets/images/song.png"),
                      ),
                    ),
                  ),
                  constWidth20,
                  Text(
                    data.title ?? "no name",
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    data.subtitle ?? "",
                    style: const TextStyle(
                      fontSize: 12,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

List<dynamic> getAllSongs(HomeScreenModel homeScreenModel) {
  List<dynamic> allSongs = [];

  allSongs.addAll(
    homeScreenModel.newTrending.where((item) => item.type == 'song'),
  );
  allSongs.addAll(
    homeScreenModel.charts.where((item) => item.type == 'song'),
  );
  allSongs.addAll(
    homeScreenModel.topPlaylists.where((item) => item.type == 'song'),
  );
  allSongs.addAll(
    homeScreenModel.tagMixes.where((item) => item.type == 'song'),
  );
  allSongs.addAll(
    homeScreenModel.artistRecos.where((item) => item.type == 'song'),
  );
  allSongs.addAll(
    homeScreenModel.newAlbums.where((item) => item.type == 'song'),
  );
  return allSongs;
}
