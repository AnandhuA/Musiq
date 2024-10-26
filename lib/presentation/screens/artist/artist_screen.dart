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
                        model.data?.image?.last.url ?? errorImage(),
                      ),
                    ),
                    AppSpacing.width30,
                    Expanded(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                model.data?.name ?? "Artist",
                                style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 2,
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
                Column(
                  children: model.data?.topSongs?.map((song) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: ListTile(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => PlayerScreen(
                                      songs: model.data!.topSongs!,
                                      initialIndex:
                                          model.data!.topSongs!.indexOf(song),
                                    ),
                                  ));
                            },
                            leading: CachedNetworkImage(
                              imageUrl:
                                  song.image?.last.imageUrl ?? errorImage(),
                              placeholder: (context, url) =>
                                  Image.asset("assets/images/song.png"),
                              errorWidget: (context, url, error) =>
                                  Image.asset("assets/images/song.png"),
                            ),
                            title: Text(song.name ?? "Null"),
                            subtitle: Text(song.album?.name ?? "Null"),
                          ),
                        );
                      }).toList() ??
                      [],
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
                                      data.image?.last.url ?? errorImage(),
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
                                      imageUrl:
                                          data.image?.last.url ?? errorImage(),
                                      errorWidget: (context, url, error) =>
                                          Image.asset(
                                              "assets/images/album.png"),
                                      placeholder: (context, url) =>
                                          Image.asset(
                                              "assets/images/album.png"),
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
                if (model.data?.singles != null &&
                    model.data!.singles!.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      "Songs",
                      style: TextStyle(
                        fontSize: 20,
                        color: AppColors.colorList[AppGlobals().colorIndex],
                      ),
                    ),
                  ),
                Column(
                  children: model.data?.singles?.map((song) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: ListTile(
                            onTap: () {
                              context.read<FeatchSongCubit>().fetchData(
                                    type: song.type ?? "",
                                    id: song.id ?? "0",
                                    imageUrl: song.image?.last.imageUrl ??
                                        errorImage(),
                                  );
                            },
                            leading: CachedNetworkImage(
                              imageUrl:
                                  song.image?.last.imageUrl ?? errorImage(),
                              placeholder: (context, url) =>
                                  Image.asset("assets/images/song.png"),
                              errorWidget: (context, url, error) =>
                                  Image.asset("assets/images/song.png"),
                            ),
                            title: Text(song.name ?? "Null"),
                            subtitle: Text(song.language ?? "Null"),
                          ),
                        );
                      }).toList() ??
                      [],
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
                  Container(
                    height: 200,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: model.data?.similarArtists?.length ?? 0,
                      itemBuilder: (context, index) {
                        final data = model.data!.similarArtists![index];

                        return GestureDetector(
                          onTap: () {
                            context.read<FeatchSongCubit>().fetchData(
                                  type: data.type ?? "",
                                  id: data.id ?? "0",
                                  imageUrl:
                                      data.image?.last.url ?? errorImage(),
                                );
                          },
                          child: Container(
                            margin: const EdgeInsets.all(10),
                            width: 150,
                            child: Column(
                              children: [
                                Expanded(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(100),
                                    child: CachedNetworkImage(
                                      imageUrl:
                                          data.image?.last.url ?? errorImage(),
                                      errorWidget: (context, url, error) =>
                                          Image.asset(
                                              "assets/images/album.png"),
                                      placeholder: (context, url) =>
                                          Image.asset(
                                              "assets/images/album.png"),
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
                                  data.aka ?? "null",
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
