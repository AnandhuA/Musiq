import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
import 'package:musiq/bloc/ThemeCubit/theme_cubit.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Row(
              children: [
                Expanded(
                  child: InkWell(
                    borderRadius: BorderRadius.circular(18),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SearchScreen(),
                        ),
                      );
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
              ],
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
                              ),
                            ));
                      }
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
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
                    title: data.title);
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
                        placeholder: (context, url) =>
                            Image.asset("assets/images/song.png"),
                        errorWidget: (context, url, error) =>
                            Image.asset("assets/images/song.png"),
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
