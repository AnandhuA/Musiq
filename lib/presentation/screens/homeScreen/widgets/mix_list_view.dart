import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musiq/bloc/Search/search_cubit.dart';
import 'package:musiq/core/colors.dart';
import 'package:musiq/core/global_variables.dart';
import 'package:musiq/core/helper_funtions.dart';
import 'package:musiq/core/sized.dart';
import 'package:musiq/models/home_screen_models/mixes.dart';
import 'package:musiq/presentation/screens/tag_mix/tag_mix.dart';

class MixListView extends StatelessWidget {
  final Mixes? mixData;
  const MixListView({super.key, required this.mixData});

  @override
  Widget build(BuildContext context) {
    return mixData?.data == null
        ? SizedBox()
        : Container(
            height: 250,
            margin: EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Mixes",
                  style: TextStyle(
                    letterSpacing: 2,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: AppColors.colorList[AppGlobals().colorIndex],
                  ),
                ),
                AppSpacing.height10,
                Expanded(
                  child: GridView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: mixData?.data?.length ?? 0,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 15,
                      crossAxisSpacing: 10,
                      childAspectRatio: 0.45,
                    ),
                    itemBuilder: (context, index) {
                      final tagMix = mixData!.data![index];
                      return GestureDetector(
                        onTap: () {
                          if (mixData?.title != null) {
                            context
                                .read<SearchCubit>()
                                .searchPlayList(query: mixData!.title!);
                          }
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => TagMix(
                                  imageUrl: tagMix.image?.first.imageUrl ??
                                      errorImage(),
                                  title: mixData?.title ?? "No",
                                ),
                              ));
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
                                        tagMix.image?.first.imageUrl ??
                                            errorImage(),
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  child: BackdropFilter(
                                    filter: ImageFilter.blur(
                                        sigmaX: 10, sigmaY: 10),
                                    child: Container(),
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.topRight,
                                child: Container(
                                  margin: EdgeInsets.only(
                                    top: 10,
                                    left: 5,
                                    right: 5,
                                  ),
                                  width: isMobile(context) ? 90 : 150,
                                  child: Text(
                                    "${tagMix.name} : ${tagMix.type}",
                                    style: TextStyle(
                                      color: AppColors.white,
                                      fontSize: 13,
                                    ),
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: CachedNetworkImage(
                                    imageUrl: tagMix.image?.last.imageUrl ??
                                        errorImage(),
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
                )
              ],
            ),
          );
  }
}
