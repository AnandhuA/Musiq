import 'package:audio_service/audio_service.dart';
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
import 'package:musiq/presentation/commanWidgets/empty_screen.dart';

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
        } else if (state is SongSearchState) {
          return ListView.separated(
            padding: EdgeInsets.only(bottom: 100),
            separatorBuilder: (context, index) => AppSpacing.height20,
            itemCount: state.model.data?.results?.length ?? 0,
            itemBuilder: (context, index) {
              final Song? song = state.model.data?.results?[index];
              return ListTile(
                onTap: () {
                  context.read<FeatchSongCubit>().fetchData(
                      type: song?.type ?? "",
                      id: song?.id ?? "",
                      imageUrl: song?.image?.last.imageUrl ?? errorImage());
                },
                leading: CachedNetworkImage(
                  imageUrl: song?.image?.last.imageUrl ?? errorImage(),
                  placeholder: (context, url) => songImagePlaceholder(),
                  errorWidget: (context, url, error) => songImagePlaceholder(),
                ),
                title: Text(song?.name ?? "No"),
                subtitle: Text(
                  song?.album?.name ?? "no",
                  maxLines: 1,
                ),
                trailing: PopupMenuButton<int>(
                  icon: Icon(Icons.more_vert_sharp),
                  onSelected: (value) {
                    // Handle selected menu action
                    final audioHandler = AppGlobals().audioHandler;
                    if (song != null) {
                      switch (value) {
                        case 0:
                          if (AppGlobals()
                              .lastPlayedSongNotifier
                              .value
                              .isNotEmpty) {
                            final mediaItem = MediaItem(
                              id: song.downloadUrl?.last.link ?? "",
                              album: song.album?.name ?? "No ",
                              title: song.label ?? "No ",
                              displayTitle: song.name ?? "",
                              artUri: Uri.parse(
                                  song.image?.last.imageUrl ?? errorImage()),
                            );

                            audioHandler.addToQueue(
                                mediaItem: mediaItem, song: song);
                          }
                          break;
                        case 1:
                          // Handle "Add to Playlist" action
                          break;
                        case 2:
                          // Handle "Share" action
                          break;
                      }
                    }
                  },
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      value: 0,
                      child: Text('Add to Queue'),
                    ),
                    PopupMenuItem(
                      value: 1,
                      child: Text('Add to Favorite'),
                    ),
                    PopupMenuItem(
                      value: 2,
                      child: Text('Add to Playlist'),
                    ),
                  ],
                ),
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
