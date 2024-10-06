import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musiq/bloc/FeatchSong/featch_song_cubit.dart';
import 'package:musiq/core/colors.dart';

class TagMixGrid extends StatelessWidget {
  final List tagMixes;
  final int itemCount;
  final double containerHeight;

  TagMixGrid({
    required this.tagMixes,
    required this.itemCount,
    required this.containerHeight,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: containerHeight,
      padding: EdgeInsets.all(10),
      child: GridView.builder(
        physics: NeverScrollableScrollPhysics(),
        itemCount: itemCount > tagMixes.length ? tagMixes.length : itemCount,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 10,
          childAspectRatio: 1.9,
        ),
        itemBuilder: (context, index) {
          final tagMix = tagMixes[index];
          final fallbackImageUrl =
              "https://static.vecteezy.com/system/resources/thumbnails/037/044/052/small_2x/ai-generated-studio-shot-of-black-headphones-over-music-note-explosion-background-with-empty-space-for-text-photo.jpg";

          return GestureDetector(
            onTap: () {
              if (tagMix.type == "radio_station") {
                context.read<FeatchSongCubit>().feachArtistSong(
                      artistName: tagMix.title,
                      imageUrl: tagMix.image,
                      title: tagMix.title,
                    );
              } else {
                context.read<FeatchSongCubit>().clickSong(
                      type: tagMix.type ?? "",
                      id: tagMix.id ?? "0",
                      imageUrl: tagMix.image,
                      title: tagMix.title,
                    );
              }
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: CachedNetworkImageProvider(
                            tagMix.image ?? fallbackImageUrl,
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                        child: Container(),
                      ),
                    ),
                  ),
                  Align(
                    alignment: index == 0 || index == 1
                        ? Alignment.topRight
                        : Alignment.topLeft,
                    child: Container(
                      margin: EdgeInsets.only(
                        top: 10,
                        left: 5,
                        right: 5,
                      ),
                      width: 90,
                      child: Text(
                        "${tagMix.title} : ${tagMix.type}",
                        style: TextStyle(fontSize: 16, color: white),
                      ),
                    ),
                  ),
                  Align(
                    alignment: index == 0 || index == 1
                        ? Alignment.centerLeft
                        : Alignment.centerRight,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: CachedNetworkImage(
                        imageUrl: tagMix.image ?? fallbackImageUrl,
                        placeholder: (context, url) =>
                            Image.asset("assets/images/song.png"),
                        errorWidget: (context, url, error) =>
                            Image.asset("assets/images/song.png"),
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
