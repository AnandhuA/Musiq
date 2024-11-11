import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:musiq/core/colors.dart';
import 'package:musiq/core/global_variables.dart';
import 'package:musiq/core/helper_funtions.dart';
import 'package:musiq/presentation/commanWidgets/snack_bar.dart';


class SongPopupMenu extends StatelessWidget {
  final dynamic song; // Use your actual song type here
  final BuildContext context;

  const SongPopupMenu({
    Key? key,
    required this.song,
    required this.context,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final audioHandler = AppGlobals().audioHandler;

    return PopupMenuButton<int>(
      icon: const Icon(Icons.more_vert_sharp),
      onSelected: (value) {
        switch (value) {
          case 0:
            if (AppGlobals().lastPlayedSongNotifier.value.isNotEmpty) {
              final mediaItem = MediaItem(
                id: song.downloadUrl?.last.link ?? "",
                album: song.album?.name ?? "No ",
                title: song.label ?? "No ",
                displayTitle: song.name ?? "",
                artUri: Uri.parse(song.image?.last.imageUrl ?? errorImage()),
              );

              audioHandler.addToQueue(mediaItem: mediaItem, song: song);
              customSnackbar(
                context: context,
                message: "${song.name} added to queue",
                bgColor: AppColors.white,
                textColor: AppColors.black,
                duration: const Duration(seconds: 5),
              );
            }
            break;
          case 1:
            // Handle "Favorite" action
            break;
          case 2:
            // Handle "Add to Playlist" action
            break;
        }
      },
      itemBuilder: (context) => [
        PopupMenuItem(
          value: 0,
          child: Row(
            children: const [
              Icon(Icons.wrap_text),
              Text('Add to Queue'),
            ],
          ),
        ),
        PopupMenuItem(
          value: 1,
          child: Row(
            children: [
              Icon(Icons.favorite), // Use your favorite icon
              const Text("Favorite"),
            ],
          ),
        ),
        PopupMenuItem(
          value: 2,
          child: const Text('Add to Playlist'),
        ),
      ],
    );
  }
}
