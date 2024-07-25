import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musiq/core/colors.dart';
import 'package:musiq/main.dart';
import 'package:musiq/screen/favoriteScreen/favorite_screen.dart';
import 'package:musiq/screen/homeScreen/home_screen.dart';
import 'package:musiq/screen/settings/ThemeCubit/theme_cubit.dart';
import 'package:musiq/screen/suggestion/bloc/EngSong/english_song_suggestion_bloc.dart';
import 'package:musiq/screen/suggestion/bloc/HindiSong/hindi_song_bloc.dart';
import 'package:musiq/screen/suggestion/bloc/MalayalamSongs/mal_songs_bloc.dart';
import 'package:musiq/screen/suggestion/bloc/TamilSongs/tamil_song_bloc.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  MainPageState createState() => MainPageState();
}

class MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
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
       context.read<EnglishSongSuggestionBloc>().add(EnglishSongSuggestionEvent());
    context.read<MalSongsBloc>().add(MalSongsEvent());
    context.read<TamilSongBloc>().add(TamilSongEvent());
    context.read<HindiSongBloc>().add(HindiSongEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        return Scaffold(
          body: Center(
            child: _widgetOptions.elementAt(_selectedIndex),
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
            selectedItemColor: accentColors[colorIndex],
            onTap: _onItemTapped,
          ),
        );
      },
    );
  }
}
