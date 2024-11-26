import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musiq/bloc/FeatchSong/fetch_song_cubit.dart';
import 'package:musiq/bloc/Search/search_cubit.dart';
import 'package:musiq/core/helper_funtions.dart';
import 'package:musiq/core/sized.dart';
import 'package:musiq/presentation/commanWidgets/empty_screen.dart';

class ArtistSearchResult extends StatelessWidget {
  const ArtistSearchResult({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchCubit, SearchState>(
      builder: (context, state) {
        if (state is SearchLoadingState) {
          return EmptyScreen(
            text1: "wait",
            size1: 15,
            text2: "song",
            size2: 20,
            text3: "loading",
            size3: 20,
            isLoading: true,
          );
        } else if (state is SearchErrorState) {
          return Center(
            child: EmptyScreen(
              text1: "Oops!",
              size1: 15,
              text2: "Something went",
              size2: 20,
              text3: "${state.error}",
              size3: 20,
            ),
          );
        } else if (state is ArtistSearchState) {
          return ListView.separated(
            padding: EdgeInsets.only(bottom: 100),
            separatorBuilder: (context, index) => AppSpacing.height20,
            itemCount: state.model.data?.results?.length ?? 0,
            itemBuilder: (context, index) {
              final song = state.model.data?.results?[index];
              return ListTile(
                onTap: () {
                  context.read<FetchSongCubit>().fetchData(
                      type: song?.type ?? "",
                      id: song?.id ?? "",
                      imageUrl: song?.image?.last.imageUrl ?? errorImage());
                },
                leading: CachedNetworkImage(
                  imageUrl: song?.image?.last.imageUrl ?? errorImage(),
                  placeholder: (context, url) => songImagePlaceholder(),
                  errorWidget: (context, url, error) => songImagePlaceholder(),
                ),
                title: Text(
                  song?.name ?? "No",
                  maxLines: 1,
                ),
              );
            },
          );
        }
        return EmptyScreen(
          text1: "show",
          size1: 15,
          text2: "Nothing",
          size2: 20,
          text3: "Artist",
          size3: 20,
        );
      },
    );
  }
}
