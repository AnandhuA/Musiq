import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:musiq/bloc/FeatchLibraty/featch_library_cubit.dart';
import 'package:musiq/core/colors.dart';
import 'package:musiq/core/global_variables.dart';
import 'package:musiq/core/sized.dart';
import 'package:musiq/bloc/favorite_bloc/favorite_bloc.dart';
import 'package:musiq/models/song_model/song.dart';
import 'package:musiq/presentation/commanWidgets/textfeild.dart';
import 'package:musiq/presentation/screens/newHomeScreen/newHomeScreen.dart';
import 'package:musiq/presentation/screens/player_screen/bottomPlayer/bottom_player.dart';
import 'package:musiq/presentation/screens/LibraryScreen/library_screen.dart';
import 'package:musiq/presentation/screens/homeScreen/home_screen.dart';
import 'package:musiq/bloc/home_screen_cubit/home_screen_cubit.dart';
import 'package:musiq/bloc/ThemeCubit/theme_cubit.dart';
import 'package:musiq/presentation/screens/homeScreen/widgets/drawer_widget.dart';
import 'package:musiq/presentation/screens/searchScreen/search_screen.dart';
import 'package:musiq/presentation/screens/search_screen/search_screen.dart';
import 'package:musiq/presentation/screens/settingsScreen/setting_screen.dart';

class LayOutPage extends StatefulWidget {
  const LayOutPage({super.key});

  @override
  LayOutPageState createState() => LayOutPageState();
}

class LayOutPageState extends State<LayOutPage> {
  int _selectedIndex = 0;

//--------widget list -----------
  static final List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    Newhomescreen(),
    NewSearchScreen(),
    LibraryScreen(),
  ];

//------ titles list ---------
  final List<String> _titles = [
    "Home",
    "New Home",
    "Search",
    "Library",
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
    context.read<FeatchLibraryCubit>().featchLibrary();
  }

  Future<void> _refreshData() async {
    context.read<HomeScreenCubit>().loadData();
    context.read<FeatchLibraryCubit>().featchLibrary();
    context.read<FavoriteBloc>().add(FeatchFavoriteSongEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, themeState) {
        return LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth >= ScreenBreakpoints.tablet) {
//---------- Desktop or Tablet Layout ---------------
              return Scaffold(
                appBar: AppBar(
                  title: _selectedIndex == 0
                      ? Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 50,
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(18),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const SearchScreen(),
                                      ),
                                    );
                                  },
                                  child: AbsorbPointer(
                                    child: CustomTextFeild(
                                      hintText: "Search",
                                      icon: Icon(
                                        Icons.search,
                                        color: AppColors
                                            .colorList[AppGlobals().colorIndex],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      : Text(_titles[_selectedIndex]),
                ),
                body: Stack(
                  children: [
                    Row(
                      children: [
                        NavigationRail(
                          backgroundColor:
                              Theme.of(context).brightness == Brightness.dark
                                  ? AppColors.black
                                  : AppColors.white,
                          selectedIndex: _selectedIndex,
                          onDestinationSelected: _onItemTapped,
                          labelType: NavigationRailLabelType.selected,
                          destinations: <NavigationRailDestination>[
                            NavigationRailDestination(
                              indicatorColor:
                                  AppColors.colorList[AppGlobals().colorIndex],
                              icon: Icon(Icons.home),
                              label: Text('Home'),
                            ),
                            NavigationRailDestination(
                              icon: Icon(Icons.newspaper),
                              label: Text('New Home'), // New Home Tab
                            ),
                            NavigationRailDestination(
                              icon: Icon(Icons.search),
                              label: Text('Search'), // New Home Tab
                            ),
                            NavigationRailDestination(
                              icon: Icon(Icons.library_music_sharp),
                              label: Text('Library'),
                            ),
                          ],
                          selectedIconTheme: IconThemeData(
                            color: AppColors.colorList[AppGlobals().colorIndex],
                          ),
                          trailing: IconButton(
                            icon: Icon(Icons.settings),
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
                                      _widgetOptions.elementAt(_selectedIndex),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    ValueListenableBuilder<List<Song>>(
                      valueListenable: AppGlobals().lastPlayedSongNotifier,
                      builder: (context, lastPlayedSongs, _) {
                        if (lastPlayedSongs.isNotEmpty) {
                          return MiniPlayer(
                            bottomPosition: 2,
                          );
                        }
                        return SizedBox();
                      },
                    ),
                  ],
                ),
              );
            } else {
//--------- Mobile Layout -------------
              return Scaffold(
                appBar: AppBar(
                  title: _selectedIndex == 0
                      ? Row(
                          children: [
                            Expanded(
                              child: InkWell(
                                borderRadius: BorderRadius.circular(18),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const SearchScreen(),
                                    ),
                                  );
                                },
                                child: AbsorbPointer(
                                  child: CustomTextFeild(
                                    hintText: "Search",
                                    icon: Icon(
                                      Icons.search,
                                      color: AppColors
                                          .colorList[AppGlobals().colorIndex],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      : Text(_titles[_selectedIndex]),
                ),
                drawer: isMobile(context) ? const DrawerWidget() : null,
                body: Stack(
                  children: [
                    RefreshIndicator(
                      onRefresh: _refreshData,
                      child: Center(
                        child: _widgetOptions.elementAt(_selectedIndex),
                      ),
                    ),
                    ValueListenableBuilder<List<Song>>(
                      valueListenable: AppGlobals().lastPlayedSongNotifier,
                      builder: (context, lastPlayedSongs, _) {
                        if (lastPlayedSongs.isNotEmpty) {
                          return MiniPlayer(
                            bottomPosition: 2,
                          );
                        }
                        return SizedBox();
                      },
                    ),
                  ],
                ),
                bottomNavigationBar: GNav(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  backgroundColor: Colors.transparent,
                  color: Colors.grey[800],
                  haptic: true,
                  activeColor: AppColors.colorList[AppGlobals().colorIndex],
                  tabBackgroundColor: AppColors
                      .colorList[AppGlobals().colorIndex]
                      .withOpacity(0.1),
                  gap: 5,
                  padding: const EdgeInsets.all(10),
                  tabMargin: const EdgeInsets.all(14),
                  tabs: const [
                    GButton(
                      icon: Icons.home,
                      text: 'Home',
                    ),
                    GButton(
                      icon: Icons.newspaper,
                      text: 'New Home',
                    ),
                    GButton(
                      icon: Icons.search,
                      text: 'Search',
                    ),
                    GButton(
                      icon: Icons.library_music_sharp,
                      text: 'Library',
                    ),
                  ],
                  selectedIndex: _selectedIndex,
                  onTabChange: _onItemTapped,
                ),
              );
            }
          },
        );
      },
    );
  }
}
