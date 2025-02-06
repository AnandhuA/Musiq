import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:musiq/core/colors.dart';
import 'package:musiq/core/global_variables.dart';
import 'package:musiq/data/hive_funtions/liked_songs_repo.dart';
import 'package:musiq/models/song_model/song.dart';

class LikeButton extends StatefulWidget {
  final Song song;
  const LikeButton({super.key, required this.song});

  @override
  State<LikeButton> createState() => _LikeButtonState();
}

class _LikeButtonState extends State<LikeButton>
    with SingleTickerProviderStateMixin {
  bool isLiked = false;
  double scale = 1.0;

  @override
  void initState() {
    super.initState();
    _checkIfLiked();
  }

  Future<void> _checkIfLiked() async {
    bool liked = await LikedSongsRepo.isSongLiked(widget.song.id ?? "");
    if (mounted) {
      setState(() => isLiked = liked);
    }
  }

  Future<void> _toggleLike() async {
    setState(() => scale = 1.2); // Start pop animation

    if (isLiked) {
      await LikedSongsRepo.removeFromLikedSongs(widget.song.id ?? "");
      log("Removed from liked: ${widget.song.name}");
    } else {
      await LikedSongsRepo.addToLikedSong(widget.song);
      log("Added to liked: ${widget.song.name}");
    }

    Future.delayed(const Duration(milliseconds: 150), () {
      if (mounted) {
        setState(() {
          isLiked = !isLiked;
          scale = 1.0; // Reset scale after animation
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggleLike,
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        transitionBuilder: (child, animation) {
          return ScaleTransition(scale: animation, child: child);
        },
        child: TweenAnimationBuilder(
          key: ValueKey(isLiked),
          tween: Tween<double>(begin: 1.0, end: scale),
          duration: const Duration(milliseconds: 150),
          builder: (context, value, child) {
            return Transform.scale(
              scale: value,
              child: Icon(
                isLiked ? Icons.thumb_up_alt : Icons.thumb_up_alt_outlined,
                color: isLiked
                    ? AppColors.colorList[AppGlobals().colorIndex]
                    : null,
                size: 28,
              ),
            );
          },
        ),
      ),
    );
  }
}
