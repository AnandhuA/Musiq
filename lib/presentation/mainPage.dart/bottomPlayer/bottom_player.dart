// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:audioplayers/audioplayers.dart';
// import 'package:musiq/data/shared_preference.dart';
// import 'package:musiq/main.dart';
// import 'package:musiq/models/song_model.dart';
// import 'package:musiq/presentation/screens/player_screen/cubit/PlayAndPause/play_and_pause_cubit.dart';
// import 'package:musiq/presentation/screens/player_screen/cubit/ProgressBar/progress_bar_cubit.dart';

// class BottomPlayerBar extends StatefulWidget {
//   final SongModel song;
//   const BottomPlayerBar({super.key, required this.song});

//   @override
//   State<BottomPlayerBar> createState() => _BottomPlayerBarState();
// }

// class _BottomPlayerBarState extends State<BottomPlayerBar> {
//   late AudioPlayer _audioPlayer;
//   bool _hasPlayed = false;

//   @override
//   void initState() {
//     super.initState();
//     lastplayed = widget.song;
//     SharedPreference.lastPlayedSong(widget.song);
//     _audioPlayer = AudioPlayer();

//     _audioPlayer.setSource(UrlSource(widget.song.url)).then(
//       (_) {
//         _audioPlayer.getDuration().then(
//               (duration) {},
//             );
//         if (!_hasPlayed) {
//           _audioPlayer.play(
//             UrlSource(
//               widget.song.url,
//             ),
//           );
//           setState(() {
//             _hasPlayed = true;
//           });
//         }
//       },
//     );

//     _audioPlayer.onPlayerStateChanged.listen(
//       (pstate) {
//         if (mounted) {
//           context.read<PlayAndPauseCubit>().togglePlayerState(pstate);
//         }
//       },
//     );

//     _audioPlayer.onPositionChanged.listen(
//       (position) {
//         if (mounted) {
//           context.read<ProgressBarCubit>().changeProgress(position);
//         }
//       },
//     );
//   }

//   @override
//   void dispose() {
//     _audioPlayer.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final double screenWidth = MediaQuery.of(context).size.width;

//     return Container(
//       color: Colors.black.withOpacity(0.8),
//       padding: const EdgeInsets.symmetric(vertical: 8.0),
//       child: Row(
//         children: [
//           ClipRRect(
//             borderRadius: BorderRadius.circular(5),
//             child: Image.network(
//               widget.song.imageUrl,
//             ),
//           ),
//           const SizedBox(width: 10),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   widget.song.title,
//                   maxLines: 1,
//                   style: const TextStyle(
//                     fontWeight: FontWeight.bold,
//                   ),
//                   overflow: TextOverflow.ellipsis,
//                 ),
//                 Text(
//                   widget.song.album,
//                   maxLines: 1,
//                   overflow: TextOverflow.ellipsis,
//                 ),
//               ],
//             ),
//           ),
//           IconButton(
//             onPressed: () {
//               // Handle previous action
//             },
//             icon: Icon(
//               Icons.skip_previous_rounded,
//               size: screenWidth * 0.08,
//             ),
//           ),
//           BlocBuilder<PlayAndPauseCubit, PlayAndPauseState>(
//             builder: (context, state) {
//               if (state is PausedState) {
//                 return IconButton(
//                   onPressed: () {
//                     _audioPlayer.pause();
//                   },
//                   icon: Icon(
//                     Icons.pause_circle_filled,
//                     size: screenWidth * 0.1,
//                   ),
//                 );
//               }
//               if (state is PlayingState) {
//                 return IconButton(
//                   onPressed: () {
//                     _audioPlayer.resume();
//                   },
//                   icon: Icon(
//                     Icons.play_circle_fill_rounded,
//                     size: screenWidth * 0.1,
//                   ),
//                 );
//               }
//               return const CircularProgressIndicator();
//             },
//           ),
//           IconButton(
//             onPressed: () {
//               // Handle next action
//             },
//             icon: Icon(
//               Icons.skip_next_rounded,
//               size: screenWidth * 0.08,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
