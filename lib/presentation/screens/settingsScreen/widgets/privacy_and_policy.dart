import 'package:flutter/material.dart';
import 'package:musiq/presentation/commanWidgets/empty_screen.dart';

class PrivacyAndPolicy extends StatelessWidget {
  const PrivacyAndPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios_new_sharp),
        ),
        title: Text("PrivacyAndPolicy"),
      ),
      body: emptyScreen(
        context: context,
        text1: "show",
        size1: 15,
        text2: "Nothing",
        size2: 20,
        text3: "PrivacyAndPolicy",
        size3: 20,
      ),
    );
  }
}
