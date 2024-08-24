import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musiq/core/colors.dart';
import 'package:musiq/main.dart';
import 'package:musiq/presentation/screens/favoriteScreen/bloc/favorite_bloc.dart';
import 'package:musiq/presentation/screens/favoriteScreen/favorite_screen.dart';
import 'package:musiq/presentation/screens/homeScreen/home_screen.dart';
import 'package:musiq/presentation/screens/homeScreen/suggestion/bloc/Trending/trending_cubit.dart';
import 'package:musiq/presentation/screens/settingsScreen/ThemeCubit/theme_cubit.dart';
import 'package:musiq/presentation/screens/homeScreen/suggestion/bloc/EngSong/english_song_suggestion_bloc.dart';
import 'package:musiq/presentation/screens/homeScreen/suggestion/bloc/HindiSong/hindi_song_bloc.dart';
import 'package:musiq/presentation/screens/homeScreen/suggestion/bloc/MalayalamSongs/mal_songs_bloc.dart';
import 'package:musiq/presentation/screens/homeScreen/suggestion/bloc/TamilSongs/tamil_song_bloc.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  MainPageState createState() => MainPageState();
}

class MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  static  final List<Widget> _widgetOptions = <Widget>[
    const HomeScreen(),
    FavoriteScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    //
    context.read<TrendingCubit>().fetchTrendingSongs();
    context.read<MalSongsBloc>().add(MalSongsEvent());
    context.read<TamilSongBloc>().add(TamilSongEvent());
    context.read<HindiSongBloc>().add(HindiSongEvent());
    context.read<FavoriteBloc>().add(FeatchFavoriteSongEvent());
    context.read<EnglishSongSuggestionBloc>().add(EnglishSongSuggestionEvent());
  }

  Future<void> _refreshData() async {
    context.read<TrendingCubit>().fetchTrendingSongs();
    context.read<MalSongsBloc>().add(MalSongsEvent());
    context.read<TamilSongBloc>().add(TamilSongEvent());
    context.read<HindiSongBloc>().add(HindiSongEvent());
    // context.read<FavoriteBloc>().add(FeatchFavoriteSongEvent());
    context.read<EnglishSongSuggestionBloc>().add(EnglishSongSuggestionEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, themeState) {
        return Scaffold(
          body: Stack(
            children: [
              RefreshIndicator(
                onRefresh: _refreshData,
                child: Center(
                  child: _widgetOptions.elementAt(_selectedIndex),
                ),
              ),
              // Positioned(
              //   bottom: 0,
              //   left: 0,
              //   right: 0,
              //   child: lastplayed != null
              //       ? BottomPlayerBar(
              //           song: lastplayed!,
              //         )
              //       : const SizedBox(),
              // ),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite),
                label: 'Favorites',
              ),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor:
                accentColors[colorIndex], 
            onTap: _onItemTapped,
          ),
        );
      },
    );
  }
}
