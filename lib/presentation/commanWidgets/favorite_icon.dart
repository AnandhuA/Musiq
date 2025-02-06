import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musiq/core/colors.dart';
import 'package:musiq/core/global_variables.dart';
import 'package:musiq/bloc/favorite_bloc/favorite_bloc.dart';
import 'package:musiq/models/song_model/song.dart';
import 'package:musiq/presentation/screens/loginScreen/login_screen.dart';

class FavoriteIcon extends StatelessWidget {
  final Song song;
  const FavoriteIcon({
    super.key,
    required this.song,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoriteBloc, FavoriteState>(
      buildWhen: (previous, current) {
        return current is FetchFavoriteSuccess;
      },
      builder: (context, state) {
        if (state is FetchFavoriteSuccess) {
          bool isFav =
              state.favorites.any((favorite) => favorite.id == song.id);

          return GestureDetector(
            onTap: () {
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
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (child, animation) {
                return ScaleTransition(
                  scale: animation,
                  child: child,
                );
              },
              child: Icon(
                isFav ? Icons.favorite : Icons.favorite_border,
                key: ValueKey<bool>(isFav), // Ensures icon change animation
                color:
                    isFav ? AppColors.colorList[AppGlobals().colorIndex] : null,
                size: 30, // Adjust the size of the icon if needed
              ),
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
