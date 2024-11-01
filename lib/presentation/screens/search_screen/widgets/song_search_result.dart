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
import 'package:musiq/presentation/commanWidgets/favorite_icon.dart';
import 'package:musiq/presentation/commanWidgets/snack_bar.dart';

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
                confirmDismiss: (direction) async {
                  final audioHandler = AppGlobals().audioHandler;
                  if (AppGlobals().lastPlayedSongNotifier.value.isEmpty) {
                    customSnackbar(
                        context: context,
                        message: "Play a song",
                        bgColor: AppColors.red,
                        textColor: AppColors.white);
                    return false;
                  }

                  if (AppGlobals()
                          .lastPlayedSongNotifier
                          .value[AppGlobals().currentSongIndex]
                          .id !=
                      song.id) {
                    final mediaItem = MediaItem(
                      id: song.downloadUrl?.last.link ?? "",
                      album: song.album?.name ?? "No Album",
                      title: song.label ?? "No Label",
                      displayTitle: song.name ?? "No Name",
                      artUri:
                          Uri.parse(song.image?.last.imageUrl ?? errorImage()),
                    );

                    audioHandler.addToQueue(mediaItem: mediaItem, song: song);
                    customSnackbar(
                        context: context,
                        message: "${song.name} added to queue",
                        bgColor: AppColors.white,
                        textColor: AppColors.black,
                        duration: Duration(seconds: 5));
                    return true;
                  } else {
                    customSnackbar(
                        context: context,
                        message: "${song.name} is already in the queue",
                        bgColor: AppColors.red,
                        textColor: AppColors.white);
                    return false;
                  }
                },
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
                  title: Text(song.name ?? "No"),
                  subtitle: Text(
                    song.album?.name ?? "no",
                    maxLines: 1,
                  ),
                  trailing: PopupMenuButton<int>(
                    icon: Icon(Icons.more_vert_sharp),
                    onSelected: (value) {
                      // Handle selected menu action
                      final audioHandler = AppGlobals().audioHandler;

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
                            customSnackbar(
                                context: context,
                                message: "${song.name} added to queue",
                                bgColor: AppColors.white,
                                textColor: AppColors.black,
                                duration: Duration(seconds: 5));
                          }
                          break;
                        case 1:

                          // Handle "Add to Playlist" action
                          break;
                        case 2:
                          // Handle "Share" action
                          break;
                      }
                    },
                    itemBuilder: (context) => [
                      PopupMenuItem(
                        value: 0,
                        child: Row(
                          children: [
                            Icon(Icons.wrap_text),
                            Text('Add to Queue'),
                          ],
                        ),
                      ),
                      PopupMenuItem(
                        value: 1,
                        child: Row(
                          children: [
                            FavoriteIcon(song: song),
                            Text("Favorite")
                          ],
                        ),
                      ),
                      PopupMenuItem(
                        value: 2,
                        child: Text('Add to Playlist'),
                      ),
                    ],
                  ),
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
