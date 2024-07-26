import 'package:flutter/material.dart';
import 'package:musiq/core/colors.dart';
import 'package:musiq/main.dart';

import 'package:musiq/models/song.dart';
import 'package:musiq/presentation/screens/player_screen/player_screen.dart';
import 'package:musiq/presentation/screens/homeScreen/suggestion/widgets/card_widget.dart';

class Suggestion extends StatelessWidget {
  final String title;
  final List<Song> suggetionSongs;
  const Suggestion({
    super.key,
    required this.title,
    required this.suggetionSongs,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "   $title Songs",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: accentColors[colorIndex],
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) => InkWell(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PlayerScreen(
                    song: suggetionSongs[index],
                  ),
                ),
              ),
              child: CardWidget(
                song: suggetionSongs[index],
              ),
            ),
            itemCount: suggetionSongs.length,
          ),
        )
      ],
    );
  }
}
