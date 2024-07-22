import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musiq/bloc/FeatchSongsBloc/featch_songs_bloc.dart';
import 'package:musiq/screen/suggestion/bloc/EngSong/english_song_suggestion_bloc.dart';

import 'package:musiq/firebase_options.dart';
import 'package:musiq/screen/homeScreen/home_screen.dart';
import 'package:musiq/screen/suggestion/bloc/HindiSong/hindi_song_bloc.dart';
import 'package:musiq/screen/suggestion/bloc/MalayalamSongs/mal_songs_bloc.dart';
import 'package:musiq/screen/suggestion/bloc/TamilSongs/tamil_song_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // await FirebaseAuth.instance.signInWithEmailAndPassword(
  //   email: "anandhu@gmail.com",
  //   password: "1234567890",
  // );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => FeatchSongsBloc()),
        BlocProvider(create: (context) => EnglishSongSuggestionBloc()),
        BlocProvider(create: (context) => MalSongsBloc()),
        BlocProvider(create: (context) => TamilSongBloc()),
        BlocProvider(create: (context) => HindiSongBloc()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const HomeScreen(),
        theme: ThemeData.dark(),
      ),
    );
  }
}
