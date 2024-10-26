import 'package:flutter/material.dart';
import 'package:musiq/presentation/commanWidgets/empty_screen.dart';

class LibraryScreen extends StatelessWidget {
  const LibraryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: emptyScreen(
        context: context,
        text1: "show",
        size1: 15,
        text2: "Nothing",
        size2: 20,
        text3: "result",
        size3: 20,
      ),
    );
  }
}
