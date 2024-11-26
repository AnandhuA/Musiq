import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musiq/bloc/home_screen_cubit/home_screen_cubit.dart';
import 'package:musiq/presentation/commanWidgets/empty_screen.dart';
import 'package:musiq/presentation/screens/homeScreen/widgets/homepage_horizontal_listview.dart';
import 'package:musiq/presentation/screens/homeScreen/widgets/homepage_lastplayed_widget.dart';
import 'package:musiq/presentation/screens/homeScreen/widgets/mix_list_view.dart';

class Homescreen extends StatelessWidget {
  const Homescreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<HomeScreenCubit, HomeScreenState>(
        builder: (context, state) {
          if (state is HomeScreenLoading) {
            return EmptyScreen(
              text1: "Show",
              size1: 15,
              text2: "Music",
              size2: 20,
              text3: "loading",
              size3: 20,
              isLoading: true,
            );
          } else if (state is HomeScreenError) {
            return Column(
              children: [
                HomepageLastplayedWidget(
                  songList: state.lastPlayedSongList ?? [],
                ),
                Expanded(
                  child: EmptyScreen(
                    text1: "Oops!",
                    size1: 15,
                    text2: "Something Wrong",
                    size2: 20,
                    text3: "status:${state.error}",
                    size3: 20,
                  ),
                ),
              ],
            );
          } else if (state is HomeScreenLoaded) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  HomepageLastplayedWidget(
                    songList: state.lastPlayedSongList ?? [],
                  ),
                  HomepageHorizontalListview(
                      sectionTitle:
                          state.newHomeScreenModel?.songdata?.trending?.title ??
                              "Trending",
                      dataList:
                          state.newHomeScreenModel?.songdata?.trending?.data ??
                              []),
                  MixListView(
                    mixData: state.newHomeScreenModel?.songdata?.mixes,
                  ),
                  HomepageHorizontalListview(
                      sectionTitle: state
                              .newHomeScreenModel?.songdata?.playlists?.title ??
                          "Playlists",
                      dataList:
                          state.newHomeScreenModel?.songdata?.playlists?.data ??
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
                      dataList: state.newHomeScreenModel?.songdata?.artistRecos
                              ?.data ??
                          []),
                  HomepageHorizontalListview(
                      sectionTitle:
                          state.newHomeScreenModel?.songdata?.charts?.title ??
                              "Charts",
                      dataList:
                          state.newHomeScreenModel?.songdata?.charts?.data ??
                              []),
                  HomepageHorizontalListview(
                      sectionTitle:
                          state.newHomeScreenModel?.songdata?.cityMod?.title ??
                              "CityMod",
                      dataList:
                          state.newHomeScreenModel?.songdata?.cityMod?.data ??
                              []),
                  HomepageHorizontalListview(
                      sectionTitle:
                          state.newHomeScreenModel?.songdata?.discover?.title ??
                              "Discover",
                      dataList:
                          state.newHomeScreenModel?.songdata?.discover?.data ??
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
                      sectionTitle:
                          state.newHomeScreenModel?.songdata?.promo10?.title ??
                              "Promo10",
                      dataList:
                          state.newHomeScreenModel?.songdata?.promo10?.data ??
                              []),
                  HomepageHorizontalListview(
                      sectionTitle:
                          state.newHomeScreenModel?.songdata?.promo11?.title ??
                              "Promo11",
                      dataList:
                          state.newHomeScreenModel?.songdata?.promo11?.data ??
                              []),
                  HomepageHorizontalListview(
                      sectionTitle:
                          state.newHomeScreenModel?.songdata?.promo12?.title ??
                              "Promo12",
                      dataList:
                          state.newHomeScreenModel?.songdata?.promo12?.data ??
                              []),
                  HomepageHorizontalListview(
                      sectionTitle:
                          state.newHomeScreenModel?.songdata?.promo13?.title ??
                              "Promo13",
                      dataList:
                          state.newHomeScreenModel?.songdata?.promo13?.data ??
                              []),
                ],
              ),
            );
          }
          return EmptyScreen(
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
