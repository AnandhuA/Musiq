import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musiq/bloc/FeatchAlbumAndPlayList/featch_album_and_play_list_cubit.dart';
import 'package:musiq/bloc/home_screen_cubit/home_screen_cubit.dart';
import 'package:musiq/core/colors.dart';
import 'package:musiq/core/global_variables.dart';
import 'package:musiq/core/helper_funtions.dart';
import 'package:musiq/data/savan_2.0.dart';
import 'package:musiq/presentation/screens/album_or_playlist_screen/new_album_or_playlist_screen.dart';

class Newhomescreen extends StatelessWidget {
  const Newhomescreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<HomeScreenCubit, HomeScreenState>(
        builder: (context, state) {
          if (state is HomeScreenLoading) {
            Center(
              child: CircularProgressIndicator(
                color: colorList[AppGlobals().colorIndex],
              ),
            );
          } else if (state is HomeScreenLoaded) {
            return BlocListener<FeatchAlbumAndPlayListCubit,
                FeatchAlbumAndPlayListState>(
              listener: (context, state) {
                if (state is FeatchAlbumAndPlayListLoading) {
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        backgroundColor: Colors.transparent,
                        content: Center(
                          child: CircularProgressIndicator(
                            color: colorList[AppGlobals().colorIndex],
                          ),
                        ),
                      );
                    },
                  );
                } else if (state is FeatchAlbumAndPlayListLoaded) {
                  Navigator.pop(context); // for close loading
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NewAlbumOrPlaylistScreen(
                          albumModel: state.albumModel,
                          playListModel: state.playListModel,
                          imageUrl: state.imageUrl,
                        ),
                      ));
                }
              },
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    if (state.newHomeScreenModel?.songdata?.trending?.data !=
                        null)
                      Container(
                        height: 200,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: state.newHomeScreenModel!.songdata!
                              .trending!.data!.length,
                          itemBuilder: (context, index) {
                            final data = state.newHomeScreenModel!.songdata!
                                .trending!.data![index];
                            log("${data.type}");
                            return GestureDetector(
                              onTap: () {
                                log("${data.type}");
                               
                                context
                                    .read<FeatchAlbumAndPlayListCubit>()
                                    .fetchData(
                                        type: data.type ?? "",
                                        id: data.id ?? "0",
                                        imageUrl: data.image!.last.imageUrl ??
                                           errorImage());
                              },
                              child: Container(
                                margin: EdgeInsets.all(10),
                                height: 200,
                                width: 150,
                                child: Column(
                                  children: [
                                    Expanded(
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: CachedNetworkImage(
                                          imageUrl:
                                              data.image!.last.imageUrl ?? "",
                                          errorWidget: (context, url, error) =>
                                              Image.asset(
                                                  "assets/images/album.png"),
                                          placeholder: (context, url) =>
                                              Image.asset(
                                                  "assets/images/album.png"),
                                        ),
                                      ),
                                    ),
                                    Text(
                                      data.name ?? "null",
                                      maxLines: 1,
                                    ),
                                    Text(
                                      data.type ?? "null",
                                      maxLines: 1,
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    Container(
                      height: 200,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: state
                            .newHomeScreenModel!.songdata!.mixes!.data!.length,
                        itemBuilder: (context, index) {
                          final data = state.newHomeScreenModel!.songdata!
                              .mixes!.data![index];
                          return GestureDetector(
                            onTap: () {
                              Saavan2.featchAlbum(albumId: data.id ?? "0");
                            },
                            child: Container(
                              margin: EdgeInsets.all(10),
                              height: 200,
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 150,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: CachedNetworkImage(
                                        imageUrl:
                                            data.image!.last.imageUrl ?? "",
                                        errorWidget: (context, url, error) =>
                                            Image.asset(
                                                "assets/images/album.png"),
                                        placeholder: (context, url) =>
                                            Image.asset(
                                                "assets/images/album.png"),
                                      ),
                                    ),
                                  ),
                                  Text(data.name ?? "null")
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
            );
          }
          return Center(
            child: Text("Error"),
          );
        },
      ),
    );
  }
}
