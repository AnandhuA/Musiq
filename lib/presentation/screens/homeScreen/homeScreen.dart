import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musiq/bloc/featchSong/featch_song_cubit.dart';
import 'package:musiq/bloc/home_screen_cubit/home_screen_cubit.dart';
import 'package:musiq/core/colors.dart';
import 'package:musiq/core/global_variables.dart';
import 'package:musiq/presentation/commanWidgets/empty_screen.dart';
import 'package:musiq/presentation/screens/album_or_playlist_screen/album_or_playlist_screen.dart';
import 'package:musiq/presentation/screens/artist/artist_screen.dart';
import 'package:musiq/presentation/screens/homeScreen/widgets/homepage_horizontal_listview.dart';
import 'package:musiq/presentation/screens/homeScreen/widgets/mix_list_view.dart';
import 'package:musiq/presentation/screens/player_screen/player_screen.dart';

class Homescreen extends StatelessWidget {
  const Homescreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<HomeScreenCubit, HomeScreenState>(
        builder: (context, state) {
          if (state is HomeScreenLoading) {
            return Center(
              child: CircularProgressIndicator(
                color: AppColors.colorList[AppGlobals().colorIndex],
              ),
            );
          } else if (state is HomeScreenLoaded) {
// ---------------- listener --------------
            return BlocListener<FeatchSongCubit, FeatchSongState>(
              listener: (context, state) {
// -------------- loading ------------------
                if (state is FeatchSongLoading) {
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        backgroundColor: Colors.transparent,
                        content: Center(
                          child: CircularProgressIndicator(
                            color: AppColors.colorList[AppGlobals().colorIndex],
                          ),
                        ),
                      );
                    },
                  );
                }
//------------------- type is album or playlist ----------------
                else if (state is FeatchAlbumAndPlayListLoaded) {
                  Navigator.pop(context); // for closing loading
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AlbumOrPlaylistScreen(
                        albumModel: state.albumModel,
                        playListModel: state.playListModel,
                        imageUrl: state.imageUrl,
                      ),
                    ),
                  );
                }
//------------------type is song ----------------------
                else if (state is FeatchSongByIDLoaded) {
                  Navigator.pop(context); // for closing loading
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PlayerScreen(
                        songs: state.songs,
                      ),
                    ),
                  );
                }
//------------------ type is Artist ------------
                else if (state is FeatchArtistLoadedState) {
                  Navigator.pop(context); //for closing loading
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ArtistScreen(model: state.model),
                      ));
                }
              },
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    HomepageHorizontalListview(
                        sectionTitle: state.newHomeScreenModel?.songdata
                                ?.trending?.title ??
                            "Trending",
                        dataList: state
                                .newHomeScreenModel?.songdata?.trending?.data ??
                            []),
                    MixListView(
                      mixData: state.newHomeScreenModel?.songdata?.mixes,
                    ),
                    HomepageHorizontalListview(
                        sectionTitle: state.newHomeScreenModel?.songdata
                                ?.playlists?.title ??
                            "Playlists",
                        dataList: state.newHomeScreenModel?.songdata?.playlists
                                ?.data ??
                            []),
                    HomepageHorizontalListview(
                        sectionTitle:
                            state.newHomeScreenModel?.songdata?.albums?.title ??
                                "Albums",
                        dataList:
                            state.newHomeScreenModel?.songdata?.albums?.data ??
                                []),
                    HomepageHorizontalListview(
                        sectionTitle: state.newHomeScreenModel?.songdata
                                ?.artistRecos?.title ??
                            "ArtistRecos",
                        dataList: state.newHomeScreenModel?.songdata
                                ?.artistRecos?.data ??
                            []),
                    HomepageHorizontalListview(
                        sectionTitle:
                            state.newHomeScreenModel?.songdata?.charts?.title ??
                                "Charts",
                        dataList:
                            state.newHomeScreenModel?.songdata?.charts?.data ??
                                []),
                    HomepageHorizontalListview(
                        sectionTitle: state
                                .newHomeScreenModel?.songdata?.cityMod?.title ??
                            "CityMod",
                        dataList:
                            state.newHomeScreenModel?.songdata?.cityMod?.data ??
                                []),
                    HomepageHorizontalListview(
                        sectionTitle: state.newHomeScreenModel?.songdata
                                ?.discover?.title ??
                            "Discover",
                        dataList: state
                                .newHomeScreenModel?.songdata?.discover?.data ??
                            []),
                    HomepageHorizontalListview(
                        sectionTitle:
                            state.newHomeScreenModel?.songdata?.radio?.title ??
                                "Radio",
                        dataList:
                            state.newHomeScreenModel?.songdata?.radio?.data ??
                                []),
                    HomepageHorizontalListview(
                        sectionTitle:
                            state.newHomeScreenModel?.songdata?.promo0?.title ??
                                "Promo0",
                        dataList:
                            state.newHomeScreenModel?.songdata?.promo0?.data ??
                                []),
                    HomepageHorizontalListview(
                        sectionTitle:
                            state.newHomeScreenModel?.songdata?.promo1?.title ??
                                "Promo1",
                        dataList:
                            state.newHomeScreenModel?.songdata?.promo1?.data ??
                                []),
                    HomepageHorizontalListview(
                        sectionTitle:
                            state.newHomeScreenModel?.songdata?.promo2?.title ??
                                "Promo2",
                        dataList:
                            state.newHomeScreenModel?.songdata?.promo2?.data ??
                                []),
                    HomepageHorizontalListview(
                        sectionTitle:
                            state.newHomeScreenModel?.songdata?.promo3?.title ??
                                "Promo3",
                        dataList:
                            state.newHomeScreenModel?.songdata?.promo3?.data ??
                                []),
                    HomepageHorizontalListview(
                        sectionTitle:
                            state.newHomeScreenModel?.songdata?.promo4?.title ??
                                "Promo4",
                        dataList:
                            state.newHomeScreenModel?.songdata?.promo4?.data ??
                                []),
                    HomepageHorizontalListview(
                        sectionTitle:
                            state.newHomeScreenModel?.songdata?.promo5?.title ??
                                "Promo5",
                        dataList:
                            state.newHomeScreenModel?.songdata?.promo5?.data ??
                                []),
                    HomepageHorizontalListview(
                        sectionTitle:
                            state.newHomeScreenModel?.songdata?.promo6?.title ??
                                "Promo6",
                        dataList:
                            state.newHomeScreenModel?.songdata?.promo6?.data ??
                                []),
                    HomepageHorizontalListview(
                        sectionTitle:
                            state.newHomeScreenModel?.songdata?.promo7?.title ??
                                "Promo7",
                        dataList:
                            state.newHomeScreenModel?.songdata?.promo7?.data ??
                                []),
                    HomepageHorizontalListview(
                        sectionTitle:
                            state.newHomeScreenModel?.songdata?.promo8?.title ??
                                "Promo8",
                        dataList:
                            state.newHomeScreenModel?.songdata?.promo8?.data ??
                                []),
                    HomepageHorizontalListview(
                        sectionTitle:
                            state.newHomeScreenModel?.songdata?.promo9?.title ??
                                "Promo9",
                        dataList:
                            state.newHomeScreenModel?.songdata?.promo9?.data ??
                                []),
                    HomepageHorizontalListview(
                        sectionTitle: state
                                .newHomeScreenModel?.songdata?.promo10?.title ??
                            "Promo10",
                        dataList:
                            state.newHomeScreenModel?.songdata?.promo10?.data ??
                                []),
                    HomepageHorizontalListview(
                        sectionTitle: state
                                .newHomeScreenModel?.songdata?.promo11?.title ??
                            "Promo11",
                        dataList:
                            state.newHomeScreenModel?.songdata?.promo11?.data ??
                                []),
                    HomepageHorizontalListview(
                        sectionTitle: state
                                .newHomeScreenModel?.songdata?.promo12?.title ??
                            "Promo12",
                        dataList:
                            state.newHomeScreenModel?.songdata?.promo12?.data ??
                                []),
                    HomepageHorizontalListview(
                        sectionTitle: state
                                .newHomeScreenModel?.songdata?.promo13?.title ??
                            "Promo13",
                        dataList:
                            state.newHomeScreenModel?.songdata?.promo13?.data ??
                                []),
                  ],
                ),
              ),
            );
          }
          return emptyScreen(
            context: context,
            text1: "show",
            size1: 15,
            text2: "Nothing",
            size2: 20,
            text3: "result",
            size3: 20,
          );
        },
      ),
    );
  }
}
