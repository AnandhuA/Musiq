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

class _LikeButtonState extends State<LikeButton> {
  bool isLiked = false;

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
    if (isLiked) {
      await LikedSongsRepo.removeFromLikedSongs(widget.song.id ?? "");
      log("Removed from liked: ${widget.song.name}");
    } else {
      await LikedSongsRepo.addToLikedSong(widget.song);
      log("Added to liked: ${widget.song.name}");
    }

    if (mounted) {
      setState(() => isLiked = !isLiked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: _toggleLike,
      icon: Icon(isLiked ? Icons.thumb_up_alt : Icons.thumb_up_alt_outlined),
      color: isLiked ? AppColors.colorList[AppGlobals().colorIndex] : null,
    );
  }
}
