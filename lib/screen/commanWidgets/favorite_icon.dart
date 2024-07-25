import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musiq/models/song.dart';
import 'package:musiq/screen/favoriteScreen/bloc/favorite_bloc.dart';

class FavoriteIcon extends StatelessWidget {
  final Song song;
  const FavoriteIcon({super.key, required this.song});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoriteBloc, FavoriteState>(
      buildWhen: (previous, current) {
        return current is FeatchFavoriteSuccess;
      },
      builder: (context, state) {
        if (state is FeatchFavoriteSuccess) {
          bool isFav =
              state.favorites.any((favorite) => favorite.id == song.id);

          log(isFav.toString());
          return IconButton(
            onPressed: () {
              if (song.id != null) {
                isFav
                    ? context
                        .read<FavoriteBloc>()
                        .add(RemoveFavoriteEvent(song: song))
                    : context
                        .read<FavoriteBloc>()
                        .add(AddFavoriteEvent(song: song));
              }
            },
            icon: Icon(
              isFav ? Icons.favorite : Icons.favorite_border,
            ),
          );
        } else {
          return const Icon(
            Icons.favorite_border,
          );
        }
      },
    );
  }
}
