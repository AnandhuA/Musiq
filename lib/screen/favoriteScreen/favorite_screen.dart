import 'package:flutter/material.dart';
import 'package:musiq/core/colors.dart';
import 'package:musiq/main.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Favorite",
        ),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return ListTile(
            trailing: IconButton(onPressed: () {}, icon: const Icon(Icons.favorite)),
            leading: Container(
              width: 50,
              height: 50,
              color: accentColors[colorIndex],
            ),
            title: const Text("Music Name"),
            subtitle: const Text("Music Movie"),
          );
        },
      ),
    );
  }
}
