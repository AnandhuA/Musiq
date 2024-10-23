// ignore_for_file: must_be_immutable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musiq/core/global_variables.dart';
import 'package:musiq/models/song_model/song.dart';
import 'package:musiq/presentation/commanWidgets/custom_app_bar.dart';
import 'package:musiq/presentation/commanWidgets/empty_screen.dart';
import 'package:musiq/presentation/commanWidgets/favorite_icon.dart';
import 'package:musiq/bloc/favorite_bloc/favorite_bloc.dart';
import 'package:musiq/presentation/screens/player_screen/bottomPlayer/bottom_player.dart';

class FavoriteScreen extends StatelessWidget {
  FavoriteScreen({super.key});
  final TextEditingController searchController = TextEditingController();

  String _currentSortOption = 'time_desc';

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
          onSortSelected: (sortOption) {
            _currentSortOption = sortOption.key;
            context.read<FavoriteBloc>().add(SortFavoriteEvent(
                  sortType: sortOption.sortType,
                  ascending: sortOption.ascending,
                ));
          },
        ),
      ),
      body: BlocBuilder<FavoriteBloc, FavoriteState>(
        builder: (context, state) {
          if (state is FavoriteLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is FeatchFavoriteSuccess) {
            List<Song> sortedFavorites = _sortFavorites(state.favorites);

            return sortedFavorites.isEmpty
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
                        itemCount: sortedFavorites.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            // onTap: () => Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (context) => PlayerScreen(
                            //       songs: sortedFavorites,
                            //       initialIndex: index,
                            //     ),
                            //   ),
                            // ),
                            trailing: FavoriteIcon(
                              song: sortedFavorites[index],
                            ),
                            leading: Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: CachedNetworkImageProvider(
                                    sortedFavorites[index]
                                            .image
                                            ?.last
                                            .imageUrl ??
                                        "",
                                  ),
                                  fit: BoxFit.fill,
                                ),
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                            title: Text(
                              sortedFavorites[index].name ?? "No",
                              maxLines: 1,
                            ),
                            subtitle: Text(
                              sortedFavorites[index].album?.name ?? "No",
                              maxLines: 1,
                            ),
                          );
                        },
                      ),
                      Positioned(
                        right: 45,
                        bottom: 145,
                        child: GestureDetector(
                          // onTap: () => Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) => PlayerScreen(
                          //       songs: sortedFavorites,
                          //       initialIndex: getRandomSongIndex(
                          //         songList: sortedFavorites,
                          //       ),
                          //       shuffle: true,
                          //     ),
                          //   ),
                          // ),
                          child: Container(
                            padding: EdgeInsets.all(14),
                            decoration: BoxDecoration(
                              color: theme.brightness == Brightness.dark
                                  ? Colors.grey.shade900
                                  : Colors.grey,
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

  List<Song> _sortFavorites(List<Song> favorites) {
    List<Song> sortedFavorites = List.from(favorites);

    switch (_currentSortOption) {
      case 'name_asc':
        sortedFavorites.sort((a, b) => a.name!.compareTo(b.name!));
        break;
      case 'name_desc':
        sortedFavorites.sort((a, b) => b.name!.compareTo(a.name!));
        break;
      case 'time_asc':
        sortedFavorites.sort(
            (a, b) => a.addedAt?.compareTo(b.addedAt ?? DateTime.now()) ?? 0);
        break;
      case 'time_desc':
        sortedFavorites.sort(
            (a, b) => b.addedAt?.compareTo(a.addedAt ?? DateTime.now()) ?? 0);
        break;
    }

    return sortedFavorites;
  }
}
