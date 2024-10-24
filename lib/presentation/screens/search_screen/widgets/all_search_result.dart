
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musiq/bloc/Search/search_cubit.dart';
import 'package:musiq/core/colors.dart';
import 'package:musiq/core/global_variables.dart';
import 'package:musiq/core/helper_funtions.dart';
import 'package:musiq/models/global_search_model/result.dart';
import 'package:musiq/presentation/commanWidgets/empty_screen.dart';

class AllSearchResult extends StatelessWidget {
  const AllSearchResult({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchCubit, SearchState>(
      builder: (context, state) {
        if (state is SearchLoadingState) {
          return Center(
            child: CircularProgressIndicator(
              color: AppColors.colorList[AppGlobals().colorIndex],
            ),
          );
        } else if (state is GobalSearchState) {
          final List<Result> topQueryResults =
              state.model.data?.topQuery?.results ?? [];
          final List<Result> songResults =
              state.model.data?.songs?.results ?? [];
          final List<Result> albumResults =
              state.model.data?.albums?.results ?? [];
          final List<Result> artistResults =
              state.model.data?.artists?.results ?? [];
          final playlistResults = state.model.data?.playlists?.results ?? [];

          return ListView(
            children: [
              // Top Query Results
              if (topQueryResults.isNotEmpty)
                _buildCategorySection("Top Queries", topQueryResults),

              // Song Results
              if (songResults.isNotEmpty)
                _buildCategorySection("Songs", songResults),

              // Album Results
              if (albumResults.isNotEmpty)
                _buildCategorySection("Albums", albumResults),

              // Artist Results
              if (artistResults.isNotEmpty)
                _buildCategorySection("Artists", artistResults),

              // Playlist Results
              if (playlistResults.isNotEmpty)
                _buildCategorySection("Playlists", playlistResults),
            ],
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
    );
  }

  // Helper method to build category section
  Widget _buildCategorySection(String title, List<dynamic> results) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        ListView.builder(
          shrinkWrap: true, // Important for nested ListView
          physics: NeverScrollableScrollPhysics(),
          itemCount: results.length,
          itemBuilder: (context, index) {
            final result = results[index];
            return ListTile(
              leading: CachedNetworkImage(
                imageUrl: result?.image?.last.url ?? errorImage(),
                placeholder: (context, url) =>
                    Image.asset("assets/images/song.png"),
                errorWidget: (context, url, error) =>
                    Image.asset("assets/images/song.png"),
              ),
              title: Text(result.title ?? "No Title"),
              subtitle: Text(result.description ?? ""),
            );
          },
        ),
      ],
    );
  }
}
