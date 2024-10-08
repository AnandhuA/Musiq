import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musiq/core/colors.dart';
import 'package:musiq/core/helper_funtions.dart';
import 'package:musiq/core/sized.dart';
import 'package:musiq/main.dart';
import 'package:musiq/bloc/home_screen_cubit/home_screen_cubit.dart';
import 'package:musiq/presentation/screens/album_or_playlist_screen/album_or_playlist_screen.dart';
import 'package:musiq/bloc/FeatchSong/featch_song_cubit.dart';
import 'package:musiq/presentation/screens/homeScreen/widgets/horzontal_song_list_widget.dart';
import 'package:musiq/presentation/screens/homeScreen/widgets/tag_mix_widget.dart';
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
                              builder: (context) => PlayerScreen(
                                songs: state.songModel,
                              ),
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
                        Text(
                          " Artist",
                          style: TextStyle(
                              fontSize: 18,
                              letterSpacing: 3,
                              height: 2,
                              fontWeight: FontWeight.bold,
                              color: colorList[colorIndex]),
                        ),
                        Container(
                          height: 100,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: state.homeScreenModel.artistRecos.length,
                            itemBuilder: (context, index) {
                              final artist =
                                  state.homeScreenModel.artistRecos[index];
                              return GestureDetector(
                                onTap: () {
                                  if (artist.type == "radio_station") {
                                    context
                                        .read<FeatchSongCubit>()
                                        .feachArtistSong(
                                          artistName: artist.title ?? "",
                                          imageUrl: artist.image ??
                                              "https://static.vecteezy.com/system/resources/thumbnails/037/044/052/small_2x/ai-generated-studio-shot-of-black-headphones-over-music-note-explosion-background-with-empty-space-for-text-photo.jpg",
                                          title: artist.title ?? "",
                                        );
                                  } else {
                                    context.read<FeatchSongCubit>().clickSong(
                                          type: artist.type ?? "",
                                          id: artist.id ?? "0",
                                          imageUrl: artist.image ??
                                              "https://static.vecteezy.com/system/resources/thumbnails/037/044/052/small_2x/ai-generated-studio-shot-of-black-headphones-over-music-note-explosion-background-with-empty-space-for-text-photo.jpg",
                                          title: artist.title ?? "",
                                        );
                                  }
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                        color: colorList[colorIndex],
                                        width: 0,
                                      ),
                                      borderRadius: BorderRadius.circular(50)),
                                  margin: EdgeInsets.all(10),
                                  padding: EdgeInsets.all(1),
                                  height: 60,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(50),
                                    child: CachedNetworkImage(
                                      imageUrl: artist.image ??
                                          "https://static.vecteezy.com/system/resources/thumbnails/037/044/052/small_2x/ai-generated-studio-shot-of-black-headphones-over-music-note-explosion-background-with-empty-space-for-text-photo.jpg",
                                      errorWidget: (context, url, error) =>
                                          Image.asset(
                                              "assets/images/artist.png"),
                                      placeholder: (context, url) =>
                                          Image.asset(
                                              "assets/images/artist.png"),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        constHeight10,
                        TagMixGrid(
                          tagMixes: state.homeScreenModel.tagMixes,
                          itemCount: 4,
                          containerHeight: isMobile(context) ? 280 : 350,
                        ),
                        constHeight10,
                        CarouselSlider(
                          items: List.generate(
                            state.homeScreenModel.charts.length,
                            (index) {
                              final playList =
                                  state.homeScreenModel.charts[index];
                              return GestureDetector(
                                onTap: () {
                                  if (playList.type == "radio_station") {
                                    context
                                        .read<FeatchSongCubit>()
                                        .feachArtistSong(
                                          artistName: playList.title ?? "",
                                          imageUrl: playList.image ??
                                              "https://static.vecteezy.com/system/resources/thumbnails/037/044/052/small_2x/ai-generated-studio-shot-of-black-headphones-over-music-note-explosion-background-with-empty-space-for-text-photo.jpg",
                                          title: playList.title ?? "",
                                        );
                                  } else {
                                    context.read<FeatchSongCubit>().clickSong(
                                          type: playList.type ?? "",
                                          id: playList.id ?? "0",
                                          imageUrl: playList.image ??
                                              "https://static.vecteezy.com/system/resources/thumbnails/037/044/052/small_2x/ai-generated-studio-shot-of-black-headphones-over-music-note-explosion-background-with-empty-space-for-text-photo.jpg",
                                          title: playList.title ?? "",
                                        );
                                  }
                                },
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: CachedNetworkImage(
                                    imageUrl: playList.image ??
                                        "https://static.vecteezy.com/system/resources/thumbnails/037/044/052/small_2x/ai-generated-studio-shot-of-black-headphones-over-music-note-explosion-background-with-empty-space-for-text-photo.jpg",
                                    errorWidget: (context, url, error) =>
                                        Image.asset("assets/images/album.png"),
                                    placeholder: (context, url) =>
                                        Image.asset("assets/images/album.png"),
                                  ),
                                ),
                              );
                            },
                          ),
                          options: CarouselOptions(
                            autoPlay: true,
                            autoPlayInterval: Duration(seconds: 8),
                            aspectRatio: isMobile(context)
                                ? 2
                                : isTablet(context)
                                    ? 5
                                    : 6,
                            enlargeCenterPage: true,
                            viewportFraction: isMobile(context) ? 0.5 : 0.2,
                          ),
                        ),
                        constHeight10,
                        state.lastplayed.isNotEmpty
                            ? Text(
                                " Last Played Songs",
                                style: TextStyle(
                                    fontSize: 25,
                                    letterSpacing: 3,
                                    height: 2,
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

                        Text(
                          " Playlist",
                          style: TextStyle(
                              fontSize: 25,
                              letterSpacing: 3,
                              height: 2,
                              fontWeight: FontWeight.bold,
                              color: colorList[colorIndex]),
                        ),
                        constHeight20,
                        HorizontalSongList(
                          model: state.homeScreenModel.topPlaylists,
                          boderRadius: 20,
                        ),
                        constHeight20,
                        isMobile(context)
                            ? TagMixGrid(
                                tagMixes:
                                    state.homeScreenModel.tagMixes.sublist(4),
                                itemCount: 4,
                                containerHeight: 280,
                              )
                            : SizedBox(),

//----------------------top played --------------------------------
                        constHeight20,
                        songList.isNotEmpty
                            ? Text(
                                "  Top Played Songs",
                                style: TextStyle(
                                    fontSize: 25,
                                    letterSpacing: 3,
                                    height: 2,
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
                          " Trending songs",
                          style: TextStyle(
                              fontSize: 25,
                              letterSpacing: 3,
                              height: 2,
                              fontWeight: FontWeight.bold,
                              color: colorList[colorIndex]),
                        ),
                        constHeight20,
                        HorizontalSongList(
                          model: state.homeScreenModel.newTrending,
                          boderRadius: 10,
                        ),

                        Text(
                          " Albums",
                          style: TextStyle(
                              fontSize: 25,
                              letterSpacing: 3,
                              height: 2,
                              fontWeight: FontWeight.bold,
                              color: colorList[colorIndex]),
                        ),
                        constHeight20,
                        HorizontalSongList(
                          model: state.homeScreenModel.newAlbums,
                          boderRadius: 10,
                        ),
                        constHeight20,
                        Text(
                          " BrowseDiscover",
                          style: TextStyle(
                              fontSize: 25,
                              letterSpacing: 3,
                              height: 2,
                              fontWeight: FontWeight.bold,
                              color: colorList[colorIndex]),
                        ),
                        constHeight20,
                        HorizontalSongList(
                          model: state.homeScreenModel.promoVxData122,
                          boderRadius: 20,
                        ),
                        constHeight10,
                        HorizontalSongList(
                          model: state.homeScreenModel.promoVxData113,
                          boderRadius: 20,
                        ),
                        constHeight10,
                        HorizontalSongList(
                          model: state.homeScreenModel.promoVxData117,
                          boderRadius: 20,
                        ),
                        constHeight10,
                        HorizontalSongList(
                          model: state.homeScreenModel.promoVxData116,
                          boderRadius: 20,
                        ),
                        constHeight10,
                        HorizontalSongList(
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
