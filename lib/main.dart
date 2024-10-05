import 'dart:async';

import 'package:audio_service/audio_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:musiq/bloc/FeatchLibraty/featch_library_cubit.dart';
import 'package:musiq/core/theme.dart';
import 'package:musiq/models/song_model.dart';
import 'package:musiq/bloc/favorite_bloc/favorite_bloc.dart';
import 'package:musiq/bloc/home_screen_cubit/home_screen_cubit.dart';
import 'package:musiq/presentation/screens/loginScreen/bloc/login_bloc.dart';
import 'package:musiq/bloc/FeatchSong/featch_song_cubit.dart';
import 'package:musiq/presentation/screens/player_screen/cubit/PlayAndPause/play_and_pause_cubit.dart';
import 'package:musiq/presentation/screens/player_screen/cubit/ProgressBar/progress_bar_cubit.dart';
import 'package:musiq/bloc/SearchSong/search_song_bloc.dart';
import 'package:musiq/bloc/ThemeCubit/theme_cubit.dart';
import 'package:musiq/presentation/screens/splashScreen/splash_screen.dart';
import 'package:musiq/core/firebase_options.dart';
import 'package:musiq/services/audio_handler.dart';
import 'package:uni_links2/uni_links.dart';

String? theme;
int colorIndex = 0;
SongModel? lastplayedSong;
String? userIsLoggedIn;
late final AudioPlayerHandler audioHandler;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Hive.initFlutter();
  Hive.registerAdapter(SongModelAdapter());
  await Hive.openBox<SongModel>('lastPlayedBox');

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late StreamSubscription _linkSubscription;
  @override
  void initState() {
    super.initState();
    _initDeepLinkListener();
    _audioPlayerInit();
  }

  void _audioPlayerInit() async {
    audioHandler = await AudioService.init(
      builder: () => AudioPlayerHandler(),
      config: AudioServiceConfig(
        androidNotificationChannelId: 'com.example.musiq.channel.audio',
        androidNotificationChannelName: 'Music Playback',
        androidNotificationIcon: 'drawable/music',
        androidShowNotificationBadge: true,
        androidNotificationOngoing: true,
        preloadArtwork: true,
      ),
    );
  }

  void _initDeepLinkListener() {
    _linkSubscription = linkStream.listen((String? link) {
      if (link != null) {
        _handleDeepLink(link);
      }
    });
  }

  void _handleDeepLink(String link) {
    Uri uri = Uri.parse(link);
    if (uri.scheme == 'musiq' && uri.host == 'example.com') {
      if (uri.pathSegments.isNotEmpty && uri.pathSegments[0] == 'song') {
        // String songId = uri.pathSegments.length > 1 ? uri.pathSegments[1] : '';
        // Navigate to the song detail screen
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => SplashScreen()),
        );
      }
    }
  }

  @override
  void dispose() {
    _linkSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ThemeCubit()),
        BlocProvider(create: (context) => SearchSongBloc()),
        BlocProvider(create: (context) => LoginBloc()),
        BlocProvider(create: (context) => FavoriteBloc()),
        BlocProvider(create: (context) => ProgressBarCubit()),
        BlocProvider(create: (context) => PlayAndPauseCubit()),
        BlocProvider(create: (context) => HomeScreenCubit()),
        BlocProvider(create: (context) => FeatchSongCubit()),
        BlocProvider(create: (context) => FeatchLibraryCubit()),
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
