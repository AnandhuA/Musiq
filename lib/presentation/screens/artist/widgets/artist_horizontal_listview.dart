import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musiq/bloc/featchSong/featch_song_cubit.dart';
import 'package:musiq/core/colors.dart';
import 'package:musiq/core/helper_funtions.dart';

class ArtistHorizontalListview extends StatelessWidget {
  final List dataList;
  const ArtistHorizontalListview({super.key, required this.dataList});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: dataList.length,
        itemBuilder: (context, index) {
          final data = dataList[index];
          log("${data.id}");
          return GestureDetector(
            onTap: () {
              context.read<FeatchSongCubit>().fetchData(
                    type: data.type ?? "",
                    id: data.id ?? "0",
                    imageUrl: (data.image != null && data.image!.isNotEmpty)
                        ? data.image!.last.imageUrl
                        : errorImage(),
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
                        imageUrl: (data.image != null && data.image!.isNotEmpty)
                            ? data.image!.last.imageUrl
                            : errorImage(),
                        errorWidget: (context, url, error) =>
                            albumImagePlaceholder(),
                        placeholder: (context, url) => albumImagePlaceholder(),
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
                    data.type ?? "null",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.grey.withOpacity(0.8),
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
