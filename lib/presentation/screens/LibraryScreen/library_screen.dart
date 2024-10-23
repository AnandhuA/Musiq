import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musiq/bloc/FeatchLibraty/featch_library_cubit.dart';
import 'package:musiq/bloc/FeatchSong/featch_song_cubit.dart';
import 'package:musiq/core/colors.dart';
import 'package:musiq/core/global_variables.dart';
import 'package:musiq/core/sized.dart';
import 'package:musiq/presentation/commanWidgets/empty_screen.dart';
import 'package:musiq/presentation/screens/album_or_playlist_screen/album_or_playlist_screen.dart';
import 'package:musiq/presentation/screens/favoriteScreen/favorite_screen.dart';
import 'package:musiq/presentation/screens/loginScreen/login_screen.dart';

class LibraryScreen extends StatelessWidget {
  const LibraryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<FeatchSongCubit, FeatchSongState>(
        listener: (context, state) {
          if (state is FeatchSongLoading) {
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
          } else if (state is FeatchSongLoaded) {
            Navigator.pop(context); // for close loading
            // Navigator.push(
            //     context,
            //     MaterialPageRoute(
            //       builder: (context) => PlayerScreen(
            //         songs: state.songModel,

            //       ),
            //     ));
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
        child: AppGlobals().userIsLoggedIn == null
            ? Center(
                child: TextButton(
                  style: TextButton.styleFrom(
                      backgroundColor: colorList[AppGlobals().colorIndex],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      minimumSize: Size(70, 50)),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginScreen(),
                        ));
                  },
                  child: const Text(
                    "LogIn",
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
              )
            : Column(
                children: [
                  ListTile(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FavoriteScreen(),
                        ),
                      );
                    },
                    leading: Icon(Icons.favorite),
                    title: Text("Favorite Songs"),
                  ),
                  constHeight10,
                  // ListTile(
                  //   onTap: () {
                  //     Navigator.push(
                  //       context,
                  //       MaterialPageRoute(
                  //         builder: (context) => LastPlayedList(),
                  //       ),
                  //     );
                  //   },
                  //   leading: Icon(Icons.history),
                  //   title: Text("Last Played"),
                  // ),
                  Divider(),
                  constHeight10,
                  Expanded(
                    child: BlocBuilder<FeatchLibraryCubit, FeatchLibraryState>(
                      builder: (context, state) {
                        log("${state.toString()}");

                        if (state is FeatchLibraryLaodingState) {
                          return Center(
                            child: CircularProgressIndicator(
                              color: colorList[AppGlobals().colorIndex],
                            ),
                          );
                        } else if (state is FeatchLibrarySuccessState) {
                          return ListView.separated(
                            separatorBuilder: (context, index) => constHeight20,
                            itemCount: state.libraryModel.length,
                            itemBuilder: (context, index) {
                              final library = state.libraryModel[index];
                              return ListTile(
                                onTap: () {
                                  context.read<FeatchSongCubit>().clickSong(
                                      type: library.type,
                                      id: library.id,
                                      imageUrl: library.imageUrl,
                                      title: library.title);
                                },
                                leading: ClipRRect(
                                  borderRadius: BorderRadius.circular(
                                    library.type == "Artist" ? 50 : 10,
                                  ),
                                  child: CachedNetworkImage(
                                    imageUrl: library.imageUrl,
                                    placeholder: (context, url) =>
                                        library.type == "Artist"
                                            ? Image.asset(
                                                "assets/images/artist.png")
                                            : library.type == "album"
                                                ? Image.asset(
                                                    "assets/images/album.png")
                                                : Image.asset(
                                                    "assets/images/song.png"),
                                    errorWidget: (context, url, error) =>
                                        library.type == "Artist"
                                            ? Image.asset(
                                                "assets/images/artist.png")
                                            : library.type == "album"
                                                ? Image.asset(
                                                    "assets/images/album.png")
                                                : Image.asset(
                                                    "assets/images/song.png"),
                                  ),
                                ),
                                title: Text(library.title),
                              );
                            },
                          );
                        } else if (state is FeatchLibraryErrorState) {
                          return emptyScreen(
                            context: context,
                            text1: "show",
                            size1: 15,
                            text2: "Nothing",
                            size2: 20,
                            text3: "Error",
                            size3: 20,
                          );
                        }

                        // Default case if no state matches
                        return emptyScreen(
                          context: context,
                          text1: "show",
                          size1: 15,
                          text2: "Nothing",
                          size2: 20,
                          text3: "No Data",
                          size3: 20,
                        );
                      },
                    ),
                  )
                ],
              ),
      ),
    );
  }
}
