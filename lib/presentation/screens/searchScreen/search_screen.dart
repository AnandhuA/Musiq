import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musiq/bloc/FeatchSong/featch_song_cubit.dart';
import 'package:musiq/core/colors.dart';
import 'package:musiq/main.dart';
import 'package:musiq/presentation/commanWidgets/textfeild.dart';
import 'package:musiq/presentation/screens/player_screen/player_screen.dart';
import 'package:musiq/bloc/SearchSong/search_song_bloc.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  SearchScreenState createState() => SearchScreenState();
}

class SearchScreenState extends State<SearchScreen> {
  final FocusNode _focusNode = FocusNode();
  final TextEditingController _controller = TextEditingController();
  Timer? _debounce;

  // Filter state
  String selectedFilter = "All";

  @override
  void initState() {
    super.initState();
    context
        .read<SearchSongBloc>()
        .add(SearchSongEvent(searchQuery: 'New songs'));
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _controller.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      context.read<SearchSongBloc>().add(SearchSongEvent(searchQuery: query));
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 15,
            horizontal: 20,
          ),
          child: Column(
            children: [
              CustomTextFeild(
                hintText: "Search",
                focusNode: _focusNode,
                controller: _controller,
                icon: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back_ios_new_sharp),
                ),
                onChanged: (value) {
                  _onSearchChanged(value);
                },
                onSubmitted: (value) {
                  context
                      .read<SearchSongBloc>()
                      .add(SearchSongEvent(searchQuery: value));
                },
              ),
              const SizedBox(height: 10),

              // Row with filter buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    onPressed: () {
                      setState(() {
                        selectedFilter = "All";
                      });
                    },
                    child: Text(
                      "All",
                      style: TextStyle(
                        color: selectedFilter == "All"
                            ? colorList[colorIndex]
                            : theme.brightness == Brightness.dark
                                ? Colors.white
                                : Colors.black,
                      ),
                    ),
                    style: TextButton.styleFrom(
                      backgroundColor: theme.brightness == Brightness.dark
                          ? Colors.white.withOpacity(0.1)
                          : Colors.black.withOpacity(0.1),
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      shape: RoundedRectangleBorder(
                        // side: selectedFilter == "All"
                        //     ? BorderSide(color: colorList[colorIndex])
                        //     : BorderSide.none,
                        borderRadius: BorderRadius.circular(15),
                        // Rounded corners
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        selectedFilter = "Albums";
                      });
                    },
                    child: Text(
                      "Albums",
                      style: TextStyle(
                        color: selectedFilter == "Albums"
                            ? colorList[colorIndex]
                            : theme.brightness == Brightness.dark
                                ? Colors.white
                                : Colors.black,
                      ),
                    ),
                    style: TextButton.styleFrom(
                      backgroundColor: theme.brightness == Brightness.dark
                          ? Colors.white.withOpacity(0.1)
                          : Colors.black.withOpacity(0.1),
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      shape: RoundedRectangleBorder(
                        // side: selectedFilter == "Albums"
                        //     ? BorderSide(color: colorList[colorIndex])
                        //     : BorderSide.none,
                        borderRadius: BorderRadius.circular(15),
                        // Rounded corners
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        selectedFilter = "Playlists";
                      });
                    },
                    child: Text(
                      "Playlists",
                      style: TextStyle(
                        color: selectedFilter == "Playlists"
                            ? colorList[colorIndex]
                            : theme.brightness == Brightness.dark
                                ? Colors.white
                                : Colors.black,
                      ),
                    ),
                    style: TextButton.styleFrom(
                      backgroundColor: theme.brightness == Brightness.dark
                          ? Colors.white.withOpacity(0.1)
                          : Colors.black.withOpacity(0.1),
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      shape: RoundedRectangleBorder(
                        // side: selectedFilter == "Artists"
                        //     ? BorderSide(color: colorList[colorIndex])
                        //     : BorderSide.none,
                        borderRadius: BorderRadius.circular(15),
                        // Rounded corners
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        selectedFilter = "Songs";
                      });
                    },
                    child: Text(
                      "Songs",
                      style: TextStyle(
                        color: selectedFilter == "Songs"
                            ? colorList[colorIndex]
                            : theme.brightness == Brightness.dark
                                ? Colors.white
                                : Colors.black,
                      ),
                    ),
                    style: TextButton.styleFrom(
                      backgroundColor: theme.brightness == Brightness.dark
                          ? Colors.white.withOpacity(0.1)
                          : Colors.black.withOpacity(0.1),
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      shape: RoundedRectangleBorder(
                        // side: selectedFilter == "Songs"
                        //     ? BorderSide(color: colorList[colorIndex])
                        //     : BorderSide.none,
                        borderRadius: BorderRadius.circular(15),
                        // Rounded corners
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 10),

              Expanded(
                child: BlocBuilder<SearchSongBloc, SearchSongState>(
                  builder: (context, state) {
                    if (state is SearchSongLoading) {
                      return Center(child: CircularProgressIndicator());
                    } else if (state is SearchSongError) {
                      return Center(child: Text('Error occurred.'));
                    } else if (state is SearchSongSuccess) {
                      final searchResult = state.searchResult;
                      final songList = state.songModel;

                      return ListView(
                        children: [
                          // Show Songs if "All" or "Songs" is selected
                          if ((selectedFilter == "All" ||
                                  selectedFilter == "Songs") &&
                              songList.isNotEmpty) ...[
                            Text(
                              '   Songs',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: colorList[colorIndex]),
                            ),
                            ...songList.map((song) => ListTile(
                                  title: Text(
                                    song.title,
                                    maxLines: 1,
                                  ),
                                  subtitle: Text(
                                    song.subtitle,
                                    maxLines: 1,
                                  ),
                                  leading: CachedNetworkImage(
                                    imageUrl: song.imageUrl,
                                    placeholder: (context, url) =>
                                        song.type == "Artist"
                                            ? Image.asset(
                                                "assets/images/artist.png")
                                            : song.type == "album"
                                                ? Image.asset(
                                                    "assets/images/album.png")
                                                : Image.asset(
                                                    "assets/images/song.png"),
                                    errorWidget: (context, url, error) =>
                                        song.type == "Artist"
                                            ? Image.asset(
                                                "assets/images/artist.png")
                                            : song.type == "album"
                                                ? Image.asset(
                                                    "assets/images/album.png")
                                                : Image.asset(
                                                    "assets/images/song.png"),
                                  ),
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              PlayerScreen(songs: [song]),
                                        ));
                                  },
                                )),
                          ],
                          // Show Albums if "All" or "Albums" is selected
                          if ((selectedFilter == "All" ||
                                  selectedFilter == "Albums") &&
                              searchResult.albums != null &&
                              searchResult.albums!.isNotEmpty) ...[
                            Text(
                              '   Albums',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: colorList[colorIndex]),
                            ),
                            ...searchResult.albums!.map((album) => ListTile(
                                  title: Text(
                                    album.title,
                                    maxLines: 1,
                                  ),
                                  subtitle: Text(
                                    album.subtitle,
                                    maxLines: 1,
                                  ),
                                  leading: CachedNetworkImage(
                                    imageUrl: album.image,
                                    placeholder: (context, url) =>
                                        album.type == "Artist"
                                            ? Image.asset(
                                                "assets/images/artist.png")
                                            : album.type == "album"
                                                ? Image.asset(
                                                    "assets/images/album.png")
                                                : Image.asset(
                                                    "assets/images/song.png"),
                                    errorWidget: (context, url, error) =>
                                        album.type == "Artist"
                                            ? Image.asset(
                                                "assets/images/artist.png")
                                            : album.type == "album"
                                                ? Image.asset(
                                                    "assets/images/album.png")
                                                : Image.asset(
                                                    "assets/images/song.png"),
                                  ),
                                  onTap: () {
                                    context.read<FeatchSongCubit>().clickSong(
                                        type: album.type,
                                        id: album.id,
                                        title: album.title,
                                        imageUrl: album.image);
                                  },
                                )),
                          ],
                          // Show Playlists if "All" is selected
                          if ((selectedFilter == "All" ||
                                  selectedFilter == "Playlists") &&
                              searchResult.playlists != null &&
                              searchResult.playlists!.isNotEmpty) ...[
                            Text(
                              '   Playlists',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: colorList[colorIndex]),
                            ),
                            ...searchResult.playlists!.map((playlist) =>
                                ListTile(
                                  title: Text(
                                    playlist.title,
                                    maxLines: 1,
                                  ),
                                  subtitle: Text(
                                    playlist.subtitle,
                                    maxLines: 1,
                                  ),
                                  leading: CachedNetworkImage(
                                    imageUrl: playlist.image,
                                    placeholder: (context, url) =>
                                        playlist.type == "Artist"
                                            ? Image.asset(
                                                "assets/images/artist.png")
                                            : playlist.type == "album"
                                                ? Image.asset(
                                                    "assets/images/album.png")
                                                : Image.asset(
                                                    "assets/images/song.png"),
                                    errorWidget: (context, url, error) =>
                                        playlist.type == "Artist"
                                            ? Image.asset(
                                                "assets/images/artist.png")
                                            : playlist.type == "album"
                                                ? Image.asset(
                                                    "assets/images/album.png")
                                                : Image.asset(
                                                    "assets/images/song.png"),
                                  ),
                                  onTap: () {
                                    context.read<FeatchSongCubit>().clickSong(
                                        type: playlist.type,
                                        id: playlist.id,
                                        title: playlist.title,
                                        imageUrl: playlist.image);
                                  },
                                )),
                          ],
                        ],
                      );
                    } else {
                      return Center(child: Text('No data available.'));
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
