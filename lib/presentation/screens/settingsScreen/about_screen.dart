import 'package:flutter/material.dart';
import 'package:musiq/presentation/commanWidgets/empty_screen.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

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
        title: Text("About"),
      ),
      body: EmptyScreen(
   
        text1: "show",
        size1: 15,
        text2: "Nothing",
        size2: 20,
        text3: "About",
        size3: 20,
      ),
    );
  }
}
