import 'package:flutter/material.dart';
import 'package:musiq/presentation/commanWidgets/empty_screen.dart';

class AllSearchResult extends StatelessWidget {
  const AllSearchResult({super.key});

  @override
  Widget build(BuildContext context) {
    return  emptyScreen(
      context: context,
      text1: "show",
      size1: 15,
      text2: "Nothing",
      size2: 20,
      text3: "All",
      size3: 20,
    );
  }
}