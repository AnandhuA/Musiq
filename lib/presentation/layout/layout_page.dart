import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:musiq/bloc/FeatchSong/fetch_song_cubit.dart';
import 'package:musiq/core/colors.dart';
import 'package:musiq/core/global_variables.dart';
import 'package:musiq/core/sized.dart';
import 'package:musiq/bloc/favorite_bloc/favorite_bloc.dart';
import 'package:musiq/models/song_model/song.dart';
import 'package:musiq/presentation/commanWidgets/empty_screen.dart';
import 'package:musiq/presentation/screens/album_or_playlist_screen/album_or_playlist_screen.dart';
import 'package:musiq/presentation/screens/artist/artist_screen.dart';
import 'package:musiq/presentation/screens/homeScreen/homeScreen.dart';
import 'package:musiq/presentation/screens/player_screen/bottomPlayer/bottom_player.dart';
import 'package:musiq/presentation/screens/libraryScreen/library_screen.dart';
import 'package:musiq/bloc/home_screen_cubit/home_screen_cubit.dart';
import 'package:musiq/bloc/ThemeCubit/theme_cubit.dart';
import 'package:musiq/presentation/screens/homeScreen/widgets/drawer_widget.dart';
import 'package:musiq/presentation/screens/player_screen/player_screen.dart';
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
    Homescreen(),
    NewSearchScreen(),
    LibraryScreen(),
  ];

//------ titles list ---------
  final List<String> _titles = [
    "Home",
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
    loadData();
    super.initState();
  }

  loadData() async {
    await context.read<HomeScreenCubit>().loadData();
    context.read<FavoriteBloc>().add(FetchFavoriteSongEvent());
  }

  Future<void> _refreshData() async {
    context.read<HomeScreenCubit>().loadData();
    context.read<FavoriteBloc>().add(FetchFavoriteSongEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, themeState) {
        return BlocListener<FetchSongCubit, FetchSongState>(
          listener: (context, state) {
// -------------- loading ------------------
            if (state is FetchSongLoading) {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext context) {
                  return AlertDialog(
                    backgroundColor: Colors.transparent,
                    content: EmptyScreen(
                      text1: "wait",
                      size1: 15,
                      text2: "playList",
                      size2: 20,
                      text3: "loading",
                      size3: 20,
                      isLoading: true,
                    ),
                  );
                },
              );
            }
//------------------- type is album or playlist ----------------
            else if (state is FetchAlbumAndPlayListLoaded) {
              Navigator.pop(context); // for closing loading
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AlbumOrPlaylistScreen(
                      albumModel: state.albumModel,
                      playListModel: state.playListModel,
                      imageUrl: state.imageUrl,
                    ),
                  ));
            }
//------------------type is song ----------------------
            else if (state is FetchSongByIDLoaded) {
              Navigator.pop(context); // for closing loading
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PlayerScreen(
                      songs: state.songs,
                    ),
                  ));
            }
//------------------ type is Artist ------------
            else if (state is FetchArtistLoadedState) {
              Navigator.pop(context); //for closing loading
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ArtistScreen(model: state.model),
                  ));
            } else if (state is FetchSongError) {
              Fluttertoast.showToast(msg: "${state.error}");
            }
          },
          child: LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth >= ScreenBreakpoints.tablet) {
//---------- Desktop or Tablet Layout ---------------
                return Scaffold(
                  appBar: AppBar(
                    title: Text(_titles[_selectedIndex]),
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
                                indicatorColor: AppColors
                                    .colorList[AppGlobals().colorIndex],
                                icon: Icon(Icons.home),
                                label: Text('Home'),
                              ),
                              NavigationRailDestination(
                                icon: Icon(Icons.search),
                                label: Text('Search'),
                              ),
                              NavigationRailDestination(
                                icon: Icon(Icons.library_music_sharp),
                                label: Text('Library'),
                              ),
                            ],
                            selectedIconTheme: IconThemeData(
                              color:
                                  AppColors.colorList[AppGlobals().colorIndex],
                            ),
                            trailing: IconButton(
                              icon: Icon(Icons.settings),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const SettingsScreen(),
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
                                    child: _widgetOptions
                                        .elementAt(_selectedIndex),
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
                    title: Text(_titles[_selectedIndex]),
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
                    backgroundColor: AppColors.transparent,
                    color: AppColors.grey,
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
          ),
        );
      },
    );
  }
}
