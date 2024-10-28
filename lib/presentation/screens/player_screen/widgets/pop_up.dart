import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musiq/bloc/featchSong/featch_song_cubit.dart';
import 'package:musiq/core/helper_funtions.dart';
import 'package:musiq/models/song_model/all.dart';

Future<Widget?> popUpWiget({
  required BuildContext context,
  required List<All> list,
}) async {
  return showModalBottomSheet(
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (BuildContext context) {
      return Expanded(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: GridView.builder(
            itemCount: list.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 0.8,
            ),
            itemBuilder: (context, index) {
              String? imageUrl;

              if (list[index].image != null && list[index].image!.isNotEmpty) {
                imageUrl = list[index].image!.last.imageUrl;
              } else {
                log("Image list is null or empty for index $index. Using placeholder image.");
                imageUrl = errorImage();
              }

              if (!isValidUrl(imageUrl)) {
                log("Invalid image URL: $imageUrl");
                imageUrl = errorImage();
              }

              return GestureDetector(
                onTap: () {
                  log("Image URL: $imageUrl");
                  context.read<FeatchSongCubit>().featchArtistSongs(
                      id: list[index].id ?? "0",
                      imageUrl: imageUrl ?? errorImage());
                },
                child: Container(
                  child: Column(
                    children: [
                      if (list[index].image != null &&
                          list[index].image!.isNotEmpty)
                        ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: CachedNetworkImage(imageUrl: imageUrl),
                        )
                      else
                        ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: albumImagePlaceholder()),
                      Text(
                        list[index].name ?? "No",
                        maxLines: 1,
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      );
    },
  );
}
