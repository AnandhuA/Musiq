// ignore_for_file: must_be_immutable

import 'dart:developer';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musiq/core/colors.dart';
import 'package:musiq/core/global_variables.dart';
import 'package:musiq/core/helper_funtions.dart';
import 'package:musiq/models/song_model/song.dart';
import 'package:musiq/presentation/commanWidgets/custom_app_bar.dart';
import 'package:musiq/presentation/commanWidgets/dismissible_funtion.dart';
import 'package:musiq/presentation/commanWidgets/empty_screen.dart';
import 'package:musiq/presentation/commanWidgets/favorite_icon.dart';
import 'package:musiq/bloc/favorite_bloc/favorite_bloc.dart';
import 'package:musiq/presentation/screens/player_screen/bottomPlayer/bottom_player.dart';
import 'package:musiq/presentation/screens/player_screen/player_screen.dart';

class FavoriteScreen extends StatelessWidget {
  FavoriteScreen({super.key});
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(
          double.infinity,
          50,
        ),
        child: SearchAppBar(
          title: "Favorite",
          searchController: searchController,
          onSearchChanged: (value) {
            context.read<FavoriteBloc>().add(SearchFavoriteEvent(query: value));
          },
          onSortSelected: (sortOption) {},
        ),
      ),
      body: BlocBuilder<FavoriteBloc, FavoriteState>(
        builder: (context, state) {
          if (state is FavoriteLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is FeatchFavoriteSuccess) {
            return state.favorites.isEmpty
                ? emptyScreen(
                    context: context,
                    text1: "show",
                    size1: 15,
                    text2: "Nothing",
                    size2: 20,
                    text3: "Songs",
                    size3: 20,
                  )
                : Stack(
                    children: [
                      ListView.builder(
                        padding: EdgeInsets.only(bottom: 100),
                        itemCount: state.favorites.length,
                        itemBuilder: (context, index) {
                          log("${state.favorites[index].image?.last.imageUrl}");
                          final song = state.favorites[index];
                          return Dismissible(
                            key: Key(song.id ?? index.toString()),
                            direction: DismissDirection.horizontal,
                            confirmDismiss: (direction) =>
                                reusableConfirmDismiss(
                              context: context,
                              song: song,
                            ),
                            background: Container(
                                color: AppColors.green,
                                alignment: Alignment.centerLeft,
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Icon(Icons.wrap_text_sharp),
                                    Icon(Icons.wrap_text_sharp),
                                  ],
                                )),
                            child: ListTile(
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PlayerScreen(
                                    songs: state.favorites,
                                    initialIndex: index,
                                  ),
                                ),
                              ),
                              trailing: FavoriteIcon(
                                song: state.favorites[index],
                              ),
                              leading: Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: CachedNetworkImageProvider(
                                      state.favorites[index].image?.last
                                              .imageUrl ??
                                          errorImage(),
                                    ),
                                    fit: BoxFit.fill,
                                  ),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                              title: Text(
                                state.favorites[index].name ?? "No",
                                maxLines: 1,
                              ),
                              subtitle: Text(
                                state.favorites[index].album?.name ?? "No",
                                maxLines: 1,
                              ),
                            ),
                          );
                        },
                      ),
                      Positioned(
                        right: 45,
                        bottom: 145,
                        child: GestureDetector(
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PlayerScreen(
                                songs: state.favorites,
                                initialIndex: getRandomSongIndex(
                                  songList: state.favorites,
                                ),
                                shuffle: true,
                              ),
                            ),
                          ),
                          child: Container(
                            padding: EdgeInsets.all(14),
                            decoration: BoxDecoration(
                              color: theme.brightness == Brightness.dark
                                  ? AppColors.grey800
                                  : AppColors.grey,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Play"),
                                Icon(Icons.shuffle),
                              ],
                            ),
                          ),
                        ),
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
                  );
          } else {
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
        },
      ),
    );
  }
}
