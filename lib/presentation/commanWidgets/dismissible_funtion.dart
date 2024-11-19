import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:musiq/core/colors.dart';
import 'package:musiq/core/global_variables.dart';
import 'package:musiq/core/helper_funtions.dart';
import 'package:musiq/presentation/commanWidgets/snack_bar.dart';

Future<bool?> reusableConfirmDismiss({
  required BuildContext context,
  required dynamic song,
}) async {
  // Check if the song queue is empty
  if (AppGlobals().lastPlayedSongNotifier.value.isEmpty) {
    customSnackbar(
      context: context,
      message: "Play a song",
      bgColor: AppColors.red,
      textColor: AppColors.white,
    );
    return false;
  }

  // Check if the song is already in the queue
  if (AppGlobals()
          .lastPlayedSongNotifier
          .value[AppGlobals().currentSongIndex]
          .id !=
      song.id) {
    final mediaItem = MediaItem(
      id: song.downloadUrl?.last.link ?? "",
      album: song.album?.name ?? "No Album",
      title: song.label ?? "No Label",
      displayTitle: song.name ?? "No Name",
      artUri: Uri.parse(song.image?.last.imageUrl ?? errorImage()),
    );

    // Add the song to the queue
    AppGlobals().audioHandler.addToQueue(mediaItem: mediaItem, song: song);

    customSnackbar(
      context: context,
      message: "${song.name} added to queue",
      bgColor: AppColors.white,
      textColor: AppColors.black,
    );

    return true;
  } else {
    customSnackbar(
      context: context,
      message: "${song.name} is already in the queue",
      bgColor: AppColors.red,
      textColor: AppColors.white,
    );
    return false;
  }
}
