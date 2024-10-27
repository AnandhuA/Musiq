import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musiq/bloc/featchSong/featch_song_cubit.dart';
import 'package:musiq/bloc/home_screen_cubit/home_screen_cubit.dart';
import 'package:musiq/core/colors.dart';
import 'package:musiq/core/global_variables.dart';
import 'package:musiq/core/helper_funtions.dart';
import 'package:musiq/presentation/commanWidgets/empty_screen.dart';
import 'package:musiq/presentation/screens/album_or_playlist_screen/album_or_playlist_screen.dart';
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
              },
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _buildHorizontalListView(
                        context,
                        "Trending",
                        state.newHomeScreenModel?.songdata?.trending?.data ??
                            []),
                    _buildHorizontalListView(context, "Mixes",
                        state.newHomeScreenModel?.songdata?.mixes?.data ?? []),
                    _buildHorizontalListView(
                        context,
                        "Playlists",
                        state.newHomeScreenModel?.songdata?.playlists?.data ??
                            []),
                    _buildHorizontalListView(context, "Albums",
                        state.newHomeScreenModel?.songdata?.albums?.data ?? []),
                    _buildHorizontalListView(
                        context,
                        "ArtistRecos",
                        state.newHomeScreenModel?.songdata?.artistRecos?.data ??
                            []),
                    _buildHorizontalListView(context, "Charts",
                        state.newHomeScreenModel?.songdata?.charts?.data ?? []),
                    _buildHorizontalListView(
                        context,
                        "CityMod",
                        state.newHomeScreenModel?.songdata?.cityMod?.data ??
                            []),
                    _buildHorizontalListView(
                        context,
                        "Discover",
                        state.newHomeScreenModel?.songdata?.discover?.data ??
                            []),
                    _buildHorizontalListView(context, "Radio",
                        state.newHomeScreenModel?.songdata?.radio?.data ?? []),
                    _buildHorizontalListView(context, "Promo0",
                        state.newHomeScreenModel?.songdata?.promo0?.data ?? []),
                    _buildHorizontalListView(context, "Promo1",
                        state.newHomeScreenModel?.songdata?.promo1?.data ?? []),
                    _buildHorizontalListView(context, "Promo2",
                        state.newHomeScreenModel?.songdata?.promo2?.data ?? []),
                    _buildHorizontalListView(context, "Promo3",
                        state.newHomeScreenModel?.songdata?.promo3?.data ?? []),
                    _buildHorizontalListView(context, "Promo4",
                        state.newHomeScreenModel?.songdata?.promo4?.data ?? []),
                    _buildHorizontalListView(context, "Promo5",
                        state.newHomeScreenModel?.songdata?.promo5?.data ?? []),
                    _buildHorizontalListView(context, "Promo6",
                        state.newHomeScreenModel?.songdata?.promo6?.data ?? []),
                    _buildHorizontalListView(context, "Promo7",
                        state.newHomeScreenModel?.songdata?.promo7?.data ?? []),
                    _buildHorizontalListView(context, "Promo8",
                        state.newHomeScreenModel?.songdata?.promo8?.data ?? []),
                    _buildHorizontalListView(context, "Promo9",
                        state.newHomeScreenModel?.songdata?.promo9?.data ?? []),
                    _buildHorizontalListView(
                        context,
                        "Promo10",
                        state.newHomeScreenModel?.songdata?.promo10?.data ??
                            []),
                    _buildHorizontalListView(
                        context,
                        "Promo11",
                        state.newHomeScreenModel?.songdata?.promo11?.data ??
                            []),
                    _buildHorizontalListView(
                        context,
                        "Promo12",
                        state.newHomeScreenModel?.songdata?.promo12?.data ??
                            []),
                    _buildHorizontalListView(
                        context,
                        "Promo13",
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

  Widget _buildHorizontalListView(
      BuildContext context, String sectionTitle, List<dynamic> dataList) {
    if (dataList.isEmpty) {
      return SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Text(
            sectionTitle,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.colorList[AppGlobals().colorIndex],
            ),
          ),
        ),
        Container(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: dataList.length,
            itemBuilder: (context, index) {
              final data = dataList[index];

              return GestureDetector(
                onTap: () {
                  context.read<FeatchSongCubit>().fetchData(
                      type: data.type ?? "",
                      id: data.id ?? "0",
                      imageUrl: data.image?.last.imageUrl ?? errorImage());
                },
                child: Container(
                  margin: const EdgeInsets.all(10),
                  width: 150,
                  child: Column(
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: CachedNetworkImage(
                            imageUrl: data.image?.last.imageUrl ?? errorImage(),
                            errorWidget: (context, url, error) =>
                                albumImagePlaceholder(),
                            placeholder: (context, url) =>
                               albumImagePlaceholder(),
                          ),
                        ),
                      ),
                      Text(
                        data.name ?? "null",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 14),
                      ),
                      Text(
                        data.type ?? "null",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.withOpacity(0.8),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
