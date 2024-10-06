import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musiq/bloc/FeatchSong/featch_song_cubit.dart';

class HorizontalSongList extends StatelessWidget {
  final List model;
  final double boderRadius;

  HorizontalSongList({
    required this.model,
    required this.boderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: ListView.separated(
        separatorBuilder: (context, index) => SizedBox(width: 10),
        itemCount: model.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final data = model[index];

          return GestureDetector(
            onTap: () {
              if (data.type == "radio_station") {
                context.read<FeatchSongCubit>().feachArtistSong(
                      artistName: data.title,
                      imageUrl: data.image,
                      title: data.title,
                    );
              } else {
                context.read<FeatchSongCubit>().clickSong(
                    type: data.type ?? "",
                    id: data.id ?? "0",
                    imageUrl: data.image,
                    title: data.title);
              }
            },
            child: SizedBox(
              width: 180,
              child: Column(
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(boderRadius),
                      child: CachedNetworkImage(
                        imageUrl: data.image ??
                            "https://static.vecteezy.com/system/resources/thumbnails/037/044/052/small_2x/ai-generated-studio-shot-of-black-headphones-over-music-note-explosion-background-with-empty-space-for-text-photo.jpg",
                        fit: BoxFit.cover,
                        placeholder: (context, url) => data.type == "Artist"
                            ? Image.asset("assets/images/artist.png")
                            : data.type == "album"
                                ? Image.asset("assets/images/album.png")
                                : Image.asset("assets/images/song.png"),
                        errorWidget: (context, url, error) =>
                            data.type == "Artist"
                                ? Image.asset("assets/images/artist.png")
                                : data.type == "album"
                                    ? Image.asset("assets/images/album.png")
                                    : Image.asset("assets/images/song.png"),
                      ),
                    ),
                  ),
                  Text(
                    data.title ?? "no name",
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w100,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    data.subtitle ?? "",
                    style: const TextStyle(
                      fontSize: 12,
                    ),
                    overflow: TextOverflow.ellipsis,
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
