import 'package:flutter/material.dart';
import 'package:musiq/presentation/commanWidgets/empty_screen.dart';

class SongSearchResult extends StatelessWidget {
  const SongSearchResult({super.key});

  @override
  Widget build(BuildContext context) {
    return emptyScreen(
      context: context,
      text1: "show",
      size1: 15,
      text2: "Nothing",
      size2: 20,
      text3: "Songs",
      size3: 20,
    );
  }
}
