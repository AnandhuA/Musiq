
import 'package:flutter/material.dart';

import 'package:musiq/screen/suggestion/suggestion.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // context.read<FeatchSongsBloc>().add(FeatchAllSongsEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Music Library')),
      body: Suggestion(),
    );
  }
}
