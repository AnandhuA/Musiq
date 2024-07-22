import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musiq/bloc/FeatchSongsBloc/featch_songs_bloc.dart';
import 'package:musiq/bloc/Suggetions/suggestions_bloc.dart';

import 'package:musiq/firebase_options.dart';
import 'package:musiq/screen/suggestion/suggestion_screen.dart';

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
        BlocProvider(create: (context) => SuggestionsBloc()),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SuggestionScreen(),
      ),
    );
  }
}
