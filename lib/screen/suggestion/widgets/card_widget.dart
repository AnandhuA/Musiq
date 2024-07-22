import 'package:flutter/material.dart';
import 'package:musiq/models/song.dart';

class CardWidget extends StatelessWidget {
  final Song song;
  const CardWidget({super.key, required this.song});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(2),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              song.image[2].url,
              fit: BoxFit.fitHeight,
            ),
          ),
          Expanded(
            child: Text(
              song.name,
              overflow: TextOverflow.fade,
            ),
          ),
          Text(song.language)
        ],
      ),
    );
  }
}
