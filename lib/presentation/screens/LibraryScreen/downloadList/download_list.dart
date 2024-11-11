import 'package:flutter/material.dart';
import 'package:musiq/presentation/commanWidgets/empty_screen.dart';

class DownloadList extends StatelessWidget {
  const DownloadList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios_new_sharp,
          ),
        ),
      ),
      body: emptyScreen(
        context: context,
        text1: "show",
        size1: 15,
        text2: "Nothing",
        size2: 20,
        text3: "Downloads",
        size3: 20,
      ),
    );
  }
}
