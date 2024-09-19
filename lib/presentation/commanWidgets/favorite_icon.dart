import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musiq/core/colors.dart';
import 'package:musiq/main.dart';
import 'package:musiq/models/song_model.dart';
import 'package:musiq/bloc/favorite_bloc/favorite_bloc.dart';
import 'package:musiq/presentation/screens/loginScreen/login_screen.dart';

class FavoriteIcon extends StatelessWidget {
  final SongModel song;
  const FavoriteIcon({
    super.key,
    required this.song,
  });

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
              if (FirebaseAuth.instance.currentUser?.email == null) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginScreen(),
                    ));
              } else {
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
              color: isFav ? colorList[colorIndex] : null,
            ),
          );
        }
        // else if (state is UserNotLoggedIn) {
        //   return IconButton(
        //       onPressed: () {
        //         if (FirebaseAuth.instance.currentUser?.email == null) {
        //           Navigator.push(
        //               context,
        //               MaterialPageRoute(
        //                 builder: (context) => LoginScreen(),
        //               ));
        //         } else {
        //           context.read<FavoriteBloc>().add(
        //                 AddFavoriteEvent(song: song),
        //               );
        //         }
        //       },
        //       icon: const Icon(
        //         Icons.favorite_border,
        //       ));
        // }
        else {
          return const Icon(
            Icons.favorite_border,
          );
        }
      },
    );
  }
}
