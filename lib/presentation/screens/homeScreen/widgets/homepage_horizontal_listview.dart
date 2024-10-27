import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musiq/bloc/featchSong/featch_song_cubit.dart';
import 'package:musiq/core/colors.dart';
import 'package:musiq/core/global_variables.dart';
import 'package:musiq/core/helper_funtions.dart';

class HomepageHorizontalListview extends StatelessWidget {
  final String sectionTitle;
  final List<dynamic> dataList;
  const HomepageHorizontalListview({
    super.key,
    required this.sectionTitle,
    required this.dataList,
  });

  @override
  Widget build(BuildContext context) {
    if (dataList.isEmpty) {
      return SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Text(
            sectionTitle,
            style: TextStyle(
              fontSize: 20,
              letterSpacing: 2,
              fontWeight: FontWeight.w500,
              color: AppColors.colorList[AppGlobals().colorIndex],
            ),
          ),
        ),
        Container(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: dataList.length,
            itemBuilder: (context, index) {
              final data = dataList[index];

              return GestureDetector(
                onTap: () {
                  context.read<FeatchSongCubit>().fetchData(
                      type: data.type ?? "",
                      id: data.id ?? "0",
                      imageUrl: data.image?.last.imageUrl ?? errorImage());
                },
                child: Container(
                  margin: const EdgeInsets.all(10),
                  width: 150,
                  child: Column(
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: data.type == "radio_station"
                              ? BorderRadius.circular(100)
                              : BorderRadius.circular(10),
                          child: CachedNetworkImage(
                            imageUrl: data.image?.last.imageUrl ?? errorImage(),
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
                        data.type ?? "null",
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
    );
  }
}
