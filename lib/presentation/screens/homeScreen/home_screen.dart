import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:musiq/core/colors.dart';
import 'package:musiq/core/sized.dart';
import 'package:musiq/main.dart';
import 'package:musiq/presentation/commanWidgets/textfeild.dart';
import 'package:musiq/bloc/home_screen_cubit/home_screen_cubit.dart';
import 'package:musiq/presentation/screens/album_or_playlist_screen/album_or_playlist_screen.dart';
import 'package:musiq/presentation/screens/homeScreen/widgets/drawer_widget.dart';
import 'package:musiq/bloc/FeatchSong/featch_song_cubit.dart';
import 'package:musiq/presentation/screens/player_screen/player_screen.dart';
import 'package:musiq/presentation/screens/searchScreen/search_screen.dart';
import 'package:musiq/presentation/screens/settingsScreen/ThemeCubit/theme_cubit.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Music',
              style: TextStyle(
                color: colorList[colorIndex],
                fontWeight: FontWeight.bold,
              ),
            ),
            actions: [
              Lottie.asset("assets/animations/Animation1.json"),
            ],
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(60),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(18),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SearchScreen(),
                          ));
                    },
                    child: AbsorbPointer(
                      child: CustomTextFeild(
                        hintText: "Search",
                        icon: Icon(
                          Icons.search,
                          color: colorList[colorIndex],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          drawer: isMobile(context)
              ? const DrawerWidget()
              : null, // Use isMobile function
          body: BlocBuilder<HomeScreenCubit, HomeScreenState>(
            builder: (context, state) {
              if (state is HomeScreenLoaded) {
                return SingleChildScrollView(
                  child: BlocListener<FeatchSongCubit, FeatchSongState>(
                    listener: (context, state) {
                      if (state is FeatchSongLoaded) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  PlayerScreen(songs: state.songModel),
                            ));
                      } else if (state is FeatchAlbumOrPlayList) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AlbumOrPlaylistScreen(
                                songModel: state.songModel,
                              ),
                            ));
                      }
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        constHeight20,
                        Text(
                          "Trending songs",
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
                        // Text(
                        //   "TagMixes",
                        //   style: TextStyle(
                        //       fontSize: 25,
                        //       fontWeight: FontWeight.bold,
                        //       color: colorList[colorIndex]),
                        // ),
                        // constHeight20,
                        // _SongList(
                        //   model: state.homeScreenModel.tagMixes,
                        //   boderRadius: 30,
                        // ),
                        // Text(
                        //   "Artist",
                        //   style: TextStyle(
                        //       fontSize: 25,
                        //       fontWeight: FontWeight.bold,
                        //       color: colorList[colorIndex]),
                        // ),
                        // constHeight20,
                        // _SongList(
                        //   model: state.homeScreenModel.artistRecos,
                        //   boderRadius: 100,
                        // ),
                        // Text(
                        //   "Radio",
                        //   style: TextStyle(
                        //       fontSize: 25,
                        //       fontWeight: FontWeight.bold,
                        //       color: colorList[colorIndex]),
                        // ),
                        // constHeight20,
                        // _SongList(
                        //   model: state.homeScreenModel.radio,
                        //   boderRadius: 100,
                        // ),
                        Text(
                          "Albums",
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
                          "Playlist",
                          style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: colorList[colorIndex]),
                        ),
                        constHeight20,
                        _SongList(
                          model: state.homeScreenModel.topPlaylists,
                          boderRadius: 20,
                        ),
                        Text(
                          "BrowseDiscover",
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
                    child: Text("Loading"),
                  ),
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
              context
                  .read<FeatchSongCubit>()
                  .clickSong(type: data.type ?? "", id: data.id ?? "0");
            },
            child: SizedBox(
              width: 180,
              child: Column(
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(boderRadius),
                      child: Image.network(
                        data.image ?? "",
                        fit: BoxFit.cover,
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
                    data.subtitle ?? "null",
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
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
