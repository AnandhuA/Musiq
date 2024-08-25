import 'package:flutter/material.dart';
import 'package:musiq/core/sized.dart';
import 'package:musiq/models/song.dart';

class CardWidget extends StatelessWidget {
  final Song song;
  const CardWidget({super.key, required this.song});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      child: Column(
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                song.image.last.url,
                fit: BoxFit.contain,
              ),
            ),
          ),
          constWidth10,
          Text(
            song.name ?? "no name",
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            song.album.name, // Assuming song has an artist property
            style: const TextStyle(fontSize: 12, color: Colors.grey),
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
