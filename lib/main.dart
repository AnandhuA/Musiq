import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musiq/core/theme.dart';
import 'package:musiq/models/song.dart';
import 'package:musiq/presentation/screens/favoriteScreen/bloc/favorite_bloc.dart';
import 'package:musiq/presentation/screens/loginScreen/bloc/login_bloc.dart';
import 'package:musiq/presentation/screens/player_screen/cubit/PlayAndPause/play_and_pause_cubit.dart';
import 'package:musiq/presentation/screens/player_screen/cubit/ProgressBar/progress_bar_cubit.dart';
import 'package:musiq/presentation/screens/searchScreen/bloc/SearchSong/search_song_bloc.dart';
import 'package:musiq/presentation/screens/settingsScreen/ThemeCubit/theme_cubit.dart';
import 'package:musiq/presentation/screens/splashScreen/splash_screen.dart';
import 'package:musiq/presentation/screens/homeScreen/suggestion/bloc/EngSong/english_song_suggestion_bloc.dart';
import 'package:musiq/core/firebase_options.dart';
import 'package:musiq/presentation/screens/homeScreen/suggestion/bloc/HindiSong/hindi_song_bloc.dart';
import 'package:musiq/presentation/screens/homeScreen/suggestion/bloc/MalayalamSongs/mal_songs_bloc.dart';
import 'package:musiq/presentation/screens/homeScreen/suggestion/bloc/TamilSongs/tamil_song_bloc.dart';
import 'package:musiq/data/shared_preference.dart';

String? theme;
int colorIndex = 0;
Song? lastplayed;
String? userIsLoggedIn;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  theme = await SharedPreference.getTheme();
  colorIndex = await SharedPreference.getAccentColorIndex() ?? 0;
  lastplayed = await SharedPreference.getLastPlayedSong();
  userIsLoggedIn = FirebaseAuth.instance.currentUser?.email;
  print(userIsLoggedIn);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => EnglishSongSuggestionBloc()),
        BlocProvider(create: (context) => MalSongsBloc()),
        BlocProvider(create: (context) => TamilSongBloc()),
        BlocProvider(create: (context) => HindiSongBloc()),
        BlocProvider(create: (context) => ThemeCubit()),
        BlocProvider(create: (context) => SearchSongBloc()),
        BlocProvider(create: (context) => LoginBloc()),
        BlocProvider(create: (context) => FavoriteBloc()),
        BlocProvider(create: (context) => ProgressBarCubit()),
        BlocProvider(create: (context) => PlayAndPauseCubit()),
      ],
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          if (state is ThemeInitial) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              home: const SplashScreen(),
              theme: ThemeClass.lightTheme,
              darkTheme: ThemeClass.darkTheme,
              themeMode: state.theme == null || state.theme == "System"
                  ? ThemeMode.system
                  : state.theme == 'Light'
                      ? ThemeMode.light
                      : ThemeMode.dark,
            );
          }
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: const SplashScreen(),
            theme: ThemeClass.lightTheme,
            darkTheme: ThemeClass.darkTheme,
            themeMode: theme == null || theme == "System"
                ? ThemeMode.system
                : theme == 'Light'
                    ? ThemeMode.light
                    : ThemeMode.dark,
          );
        },
      ),
    );
  }
}
