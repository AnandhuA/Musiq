import 'package:flutter/material.dart';
import 'package:musiq/models/song.dart';

class CardWidget extends StatelessWidget {
  final Song song;
  const CardWidget({super.key, required this.song});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              song.image.last.url,
              fit: BoxFit.fitWidth,
              height: 180,
            ),
          ),
          Expanded(
            child: Text(
              song.name,
              overflow: TextOverflow.clip,
            ),
          ),
        ],
      ),
    );
  }
}
