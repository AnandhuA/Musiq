import 'dart:developer';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musiq/bloc/featchSong/featch_song_cubit.dart';
import 'package:musiq/core/colors.dart';
import 'package:musiq/core/global_variables.dart';
import 'package:musiq/core/helper_funtions.dart';
import 'package:musiq/core/sized.dart';
import 'package:musiq/models/artist_model/artist_model.dart';
import 'package:musiq/models/song_model/song.dart';
import 'package:musiq/presentation/commanWidgets/popup_menu.dart';
import 'package:musiq/presentation/screens/artist/widgets/artist_horizontal_listview.dart';
import 'package:musiq/presentation/screens/player_screen/bottomPlayer/bottom_player.dart';
import 'package:musiq/presentation/screens/player_screen/player_screen.dart';

class ArtistScreen extends StatelessWidget {
  final ArtistModel model;
  const ArtistScreen({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    log("${model.data?.availableLanguages}");
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(model.data?.type ?? "Artist"),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios_new_sharp),
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 60,
                      backgroundImage: CachedNetworkImageProvider(
                        (model.data?.image?.isNotEmpty ?? false)
                            ? model.data!.image!.last.imageUrl
                            : errorImage(),
                      ),
                    ),
                    AppSpacing.width30,
                    Expanded(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  model.data?.name ?? "Artist",
                                  maxLines: 2,
                                  style: TextStyle(
                                    fontSize: 30,
                                    overflow: TextOverflow.ellipsis,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 2,
                                  ),
                                ),
                              ),
                              AppSpacing.width10,
                              if (model.data?.isVerified != null)
                                model.data?.isVerified
                                    ? Icon(Icons.verified)
                                    : SizedBox()
                            ],
                          ),
                          Text(
                            model.data?.availableLanguages?.join(", ") ??
                                "Nothing",
                            style: TextStyle(
                              fontSize: 10,
                            ),
                            maxLines: 1,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                if (model.data?.topSongs != null &&
                    model.data!.topSongs!.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      "Top Songs",
                      style: TextStyle(
                        fontSize: 20,
                        color: AppColors.colorList[AppGlobals().colorIndex],
                      ),
                    ),
                  ),
                if (model.data?.topSongs?.length != null)
                  Container(
                    height: 230,
                    child: PageView.builder(
                      itemCount:
                          ((model.data!.topSongs!.length + 2) / 3).floor(),
                      pageSnapping: true,
                      controller: PageController(
                        viewportFraction: 0.9,
                      ),
                      itemBuilder: (context, pageIndex) {
                        return Transform.translate(
                          offset: Offset(
                              isMobile(context)
                                  ? -22
                                  : isTablet(context)
                                      ? -38
                                      : -70,
                              0),
                          child: Column(
                            children: List.generate(3, (itemIndex) {
                              final index = pageIndex * 3 + itemIndex;
                              if (index >= model.data!.topSongs!.length) {
                                return SizedBox();
                              }
                                final Song song = model.data!.topSongs![index];
                              return Container(
                                child: ListTile(
                                  leading: ClipRRect(
                                    borderRadius: BorderRadius.circular(5),
                                    child: CachedNetworkImage(
                                      imageUrl: model.data!.topSongs![index]
                                              .image?.last.imageUrl ??
                                          errorImage(),
                                      placeholder: (context, url) =>
                                          songImagePlaceholder(),
                                      errorWidget: (context, url, error) =>
                                          songImagePlaceholder(),
                                    ),
                                  ),
                                  title: Text(
                                    model.data!.topSongs![index].name ?? "No",
                                    maxLines: 1,
                                  ),
                                  subtitle: Text(
                                    model.data!.topSongs![index].album?.name ??
                                        "No",
                                    maxLines: 1,
                                  ),
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => PlayerScreen(
                                            songs: model.data!.topSongs!,
                                            initialIndex: index,
                                          ),
                                        ));
                                  },
                                  trailing: SongPopupMenu(song: song, context: context)
                                ),
                              );
                            }),
                          ),
                        );
                      },
                    ),
                  ),
                if (model.data?.topAlbums != null &&
                    model.data!.topAlbums!.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      "Top Albums",
                      style: TextStyle(
                        fontSize: 20,
                        color: AppColors.colorList[AppGlobals().colorIndex],
                      ),
                    ),
                  ),
                if (model.data?.topAlbums != null &&
                    model.data!.topAlbums!.isNotEmpty)
                  Container(
                    height: 200,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: model.data?.topAlbums?.length ?? 0,
                      itemBuilder: (context, index) {
                        final data = model.data!.topAlbums![index];

                        return GestureDetector(
                          onTap: () {
                            context.read<FeatchSongCubit>().fetchData(
                                  type: data.type ?? "",
                                  id: data.id ?? "0",
                                  imageUrl:
                                      data.image?.last.imageUrl ?? errorImage(),
                                );
                          },
                          child: Container(
                            margin: const EdgeInsets.all(10),
                            width: 150,
                            child: Column(
                              children: [
                                Expanded(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: CachedNetworkImage(
                                      imageUrl: data.image?.last.imageUrl ??
                                          errorImage(),
                                      errorWidget: (context, url, error) =>
                                          albumImagePlaceholder(),
                                      placeholder: (context, url) =>
                                          albumImagePlaceholder(),
                                    ),
                                  ),
                                ),
                                Text(
                                  data.name ?? "null",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(fontSize: 14),
                                ),
                                Text(
                                  data.description ?? "null",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey.withOpacity(0.8),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                if (model.data?.similarArtists != null &&
                    model.data!.similarArtists!.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      "Similar Artists",
                      style: TextStyle(
                        fontSize: 20,
                        color: AppColors.colorList[AppGlobals().colorIndex],
                      ),
                    ),
                  ),
                if (model.data?.similarArtists != null &&
                    model.data!.similarArtists!.isNotEmpty)
                  ArtistHorizontalListview(
                      dataList: model.data?.similarArtists ?? []),
                if (model.data?.singles != null &&
                    model.data!.singles!.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      "You Might Also Like",
                      style: TextStyle(
                        fontSize: 20,
                        color: AppColors.colorList[AppGlobals().colorIndex],
                      ),
                    ),
                  ),
                GridView.builder(
                  physics:
                      NeverScrollableScrollPhysics(), // Prevent inner scrolling
                  shrinkWrap:
                      true, // Allow GridView to take only as much space as needed
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3, // Number of columns
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childAspectRatio: 0.9, // Aspect ratio for items
                  ),
                  itemCount: model.data?.singles?.length ?? 0,
                  itemBuilder: (context, index) {
                    final song = model.data!.singles![index];
                    return GestureDetector(
                      onTap: () {
                        context.read<FeatchSongCubit>().fetchData(
                              type: song.type ?? "",
                              id: song.id ?? "0",
                              imageUrl:
                                  song.image?.last.imageUrl ?? errorImage(),
                            );
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: CachedNetworkImage(
                                imageUrl:
                                    song.image?.last.imageUrl ?? errorImage(),
                                placeholder: (context, url) =>
                                    songImagePlaceholder(),
                                errorWidget: (context, url, error) =>
                                    songImagePlaceholder(),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Text(
                            song.name ?? "Null",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            song.language ?? "Null",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                AppSpacing.height50,
                AppSpacing.height50
              ],
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
      ),
    );
  }
}
