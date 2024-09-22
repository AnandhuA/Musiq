// ignore_for_file: must_be_immutable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musiq/models/song_model.dart';
import 'package:musiq/presentation/commanWidgets/custom_app_bar.dart';
import 'package:musiq/presentation/commanWidgets/favorite_icon.dart';
import 'package:musiq/bloc/favorite_bloc/favorite_bloc.dart';
import 'package:musiq/presentation/screens/player_screen/player_screen.dart';

class FavoriteScreen extends StatelessWidget {
  FavoriteScreen({super.key});
  final TextEditingController searchController = TextEditingController();

  String _currentSortOption = 'time_desc';

  @override
  Widget build(BuildContext context) {
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
            List<SongModel> sortedFavorites = _sortFavorites(state.favorites);

            return sortedFavorites.isEmpty
                ? const Center(
                    child: Text("No Favorite"),
                  )
                : ListView.builder(
                    itemCount: sortedFavorites.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PlayerScreen(
                              songs: sortedFavorites,
                              initialIndex: index,
                            ),
                          ),
                        ),
                        trailing: FavoriteIcon(
                          song: sortedFavorites[index],
                        ),
                        leading: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: CachedNetworkImageProvider(
                                sortedFavorites[index].imageUrl,
                              ),
                              fit: BoxFit.fill,
                            ),
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        title: Text(
                          sortedFavorites[index].title,
                          maxLines: 1,
                        ),
                        subtitle: Text(
                          sortedFavorites[index].album,
                          maxLines: 1,
                        ),
                      );
                    },
                  );
          } else {
            return const Center(
              child: Text("Error"),
            );
          }
        },
      ),
    );
  }

  List<SongModel> _sortFavorites(List<SongModel> favorites) {
    List<SongModel> sortedFavorites = List.from(favorites);

    switch (_currentSortOption) {
      case 'name_asc':
        sortedFavorites.sort((a, b) => a.title.compareTo(b.title));
        break;
      case 'name_desc':
        sortedFavorites.sort((a, b) => b.title.compareTo(a.title));
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
