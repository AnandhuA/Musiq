import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musiq/bloc/featchSong/featch_song_cubit.dart';
import 'package:musiq/bloc/Search/search_cubit.dart';
import 'package:musiq/core/colors.dart';
import 'package:musiq/core/global_variables.dart';
import 'package:musiq/core/helper_funtions.dart';
import 'package:musiq/core/sized.dart';
import 'package:musiq/models/song_model/song.dart';
import 'package:musiq/presentation/commanWidgets/dismissible_funtion.dart';
import 'package:musiq/presentation/commanWidgets/empty_screen.dart';
import 'package:musiq/presentation/commanWidgets/bottom_sheet.dart';

class SongSearchResult extends StatelessWidget {
  const SongSearchResult({super.key});

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
        } else if (state is SearchErrorState) {
          return Center(
            child: emptyScreen(
              context: context,
              text1: "show",
              size1: 15,
              text2: "Nothing",
              size2: 20,
              text3: "${state.error}",
              size3: 20,
            ),
          );
        } else if (state is SongSearchState) {
          return ListView.separated(
            padding: EdgeInsets.only(bottom: 100),
            separatorBuilder: (context, index) => AppSpacing.height20,
            itemCount: state.model.data?.results?.length ?? 0,
            itemBuilder: (context, index) {
              final Song song = state.model.data!.results![index];
              return Dismissible(
                key: Key(song.id ?? index.toString()),
                direction: DismissDirection.horizontal,
                confirmDismiss: (direction) => reusableConfirmDismiss(
                  context: context,
                  song: song,
                ),
                background: Container(
                    color: AppColors.green,
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(Icons.wrap_text_sharp),
                        Icon(Icons.wrap_text_sharp),
                      ],
                    )),
                child: ListTile(
                    onTap: () {
                      context.read<FeatchSongCubit>().fetchData(
                          type: song.type ?? "",
                          id: song.id ?? "",
                          imageUrl: song.image?.last.imageUrl ?? errorImage());
                    },
                    leading: CachedNetworkImage(
                      imageUrl: song.image?.last.imageUrl ?? errorImage(),
                      placeholder: (context, url) => songImagePlaceholder(),
                      errorWidget: (context, url, error) =>
                          songImagePlaceholder(),
                    ),
                    title: Text(
                      song.name ?? "No",
                      maxLines: 1,
                    ),
                    subtitle: Text(
                      song.album?.name ?? "no",
                      maxLines: 1,
                    ),
                    trailing: SongOptionsBottomSheet(song: song)),
              );
            },
          );
        }
        return emptyScreen(
          context: context,
          text1: "show",
          size1: 15,
          text2: "Nothing",
          size2: 20,
          text3: "Song",
          size3: 20,
        );
      },
    );
  }
}
