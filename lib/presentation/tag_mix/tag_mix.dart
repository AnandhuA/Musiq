import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musiq/bloc/Search/search_cubit.dart';
import 'package:musiq/bloc/featchSong/featch_song_cubit.dart';
import 'package:musiq/core/colors.dart';
import 'package:musiq/core/global_variables.dart';
import 'package:musiq/core/helper_funtions.dart';
import 'package:musiq/core/sized.dart';
import 'package:musiq/presentation/commanWidgets/empty_screen.dart';

class TagMix extends StatelessWidget {
  final String imageUrl;
  final String title;
  const TagMix({
    super.key,
    required this.imageUrl,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            "Mix",
            style: TextStyle(
              color: AppColors.colorList[AppGlobals().colorIndex],
            ),
          ),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios_new_sharp),
          ),
        ),
        body: Column(
          children: [
            Container(
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.symmetric(
                horizontal: isDesktop(context) ? 30 : 0,
              ),
              child: Row(
                children: [
                  Container(
                    width: isMobile(context) ? 220 : 280,
                    height: isMobile(context) ? 200 : 250,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: CachedNetworkImage(
                        imageUrl: imageUrl,
                        fit: BoxFit.cover,
                        errorWidget: (context, url, error) =>
                            albumImagePlaceholder(),
                        placeholder: (context, url) => albumImagePlaceholder(),
                      ),
                    ),
                  ),
                  AppSpacing.width20,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 5,
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: AppColors.colorList[AppGlobals().colorIndex],
                          ),
                        ),
                        Text(
                          "",
                          overflow: TextOverflow.ellipsis,
                          maxLines: 5,
                        ),
                        Text(
                          "",
                          overflow: TextOverflow.ellipsis,
                          maxLines: 5,
                        ),
                        Text(
                          "",
                          overflow: TextOverflow.ellipsis,
                          maxLines: 5,
                        ),
                        AppSpacing.height10,
                      ],
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: BlocBuilder<SearchCubit, SearchState>(
                builder: (context, state) {
                  if (state is SearchLoadingState) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: AppColors.colorList[AppGlobals().colorIndex],
                      ),
                    );
                  } else if (state is PlayListSearchState) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: GridView.builder(
                        padding: EdgeInsets.only(bottom: 100),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          childAspectRatio: 1,
                        ),
                        itemCount: state.model.data?.results?.length ?? 0,
                        itemBuilder: (context, index) {
                          final song = state.model.data?.results?[index];
                          return GestureDetector(
                            onTap: () {
                              context.read<FeatchSongCubit>().fetchData(
                                  type: song?.type ?? "",
                                  id: song?.id ?? "",
                                  imageUrl: song?.image?.last.imageUrl ??
                                      errorImage());
                            },
                            child: GridTile(
                              child: CachedNetworkImage(
                                imageUrl:
                                    song?.image?.last.imageUrl ?? errorImage(),
                                placeholder: (context, url) =>
                                    songImagePlaceholder(),
                                errorWidget: (context, url, error) =>
                                    songImagePlaceholder(),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  }
                  return emptyScreen(
                    context: context,
                    text1: "show",
                    size1: 15,
                    text2: "Nothing",
                    size2: 20,
                    text3: "Playlist",
                    size3: 20,
                  );
                },
              ),
            ),
          ],
        ));
  }
}
