import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musiq/core/colors.dart';
import 'package:musiq/core/sized.dart';
import 'package:musiq/main.dart';
import 'package:musiq/bloc/favorite_bloc/favorite_bloc.dart';
import 'package:musiq/presentation/screens/favoriteScreen/favorite_screen.dart';
import 'package:musiq/presentation/screens/homeScreen/home_screen.dart';
import 'package:musiq/bloc/home_screen_cubit/home_screen_cubit.dart';
import 'package:musiq/bloc/ThemeCubit/theme_cubit.dart';
import 'package:musiq/presentation/screens/settingsScreen/setting_screen.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  MainPageState createState() => MainPageState();
}

class MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
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

    context.read<HomeScreenCubit>().loadData();

    context.read<FavoriteBloc>().add(FeatchFavoriteSongEvent());
  }

  Future<void> _refreshData() async {
    context.read<HomeScreenCubit>().loadData();

    context.read<FavoriteBloc>().add(FeatchFavoriteSongEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, themeState) {
        return LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth >= ScreenBreakpoints.tablet) {
              // Desktop or Tablet Layout
              return Scaffold(
                body: Row(
                  children: [
                    NavigationRail(
                      backgroundColor:
                          Theme.of(context).brightness == Brightness.dark
                              ? black
                              : white,
                      selectedIndex: _selectedIndex,
                      onDestinationSelected: _onItemTapped,
                      labelType: NavigationRailLabelType.selected,
                      destinations: const <NavigationRailDestination>[
                        NavigationRailDestination(
                          indicatorColor: Colors.red,
                          icon: Icon(Icons.home),
                          label: Text('Home'),
                        ),
                        NavigationRailDestination(
                          icon: Icon(Icons.favorite),
                          label: Text('Favorites'),
                        ),
                      ],
                      selectedIconTheme: IconThemeData(
                        color: colorList[colorIndex],
                      ),
                      trailing: IconButton(
                        icon: Icon(
                          Icons.settings,
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SettingsScreen(),
                            ),
                          );
                        },
                      ),
                    ),
                    Expanded(
                      child: RefreshIndicator(
                        onRefresh: _refreshData,
                        child: Row(
                          children: [
                            Expanded(
                                child:
                                    _widgetOptions.elementAt(_selectedIndex)),
                            // Container(
                            //   width: 500, // Adjust width as needed
                            //   // child: PlayerScreen(
                            //   //   songs: [sampleSong], // Provide songs list here
                            //   //   initialIndex: 0,
                            //   // ),
                            // ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            } else {
              // Mobile Layout
              return Scaffold(
                body: Stack(
                  children: [
                    RefreshIndicator(
                      onRefresh: _refreshData,
                      child: Center(
                        child: _widgetOptions.elementAt(_selectedIndex),
                      ),
                    ),
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
                  selectedItemColor: colorList[colorIndex],
                  onTap: _onItemTapped,
                ),
              );
            }
          },
        );
      },
    );
  }
}
