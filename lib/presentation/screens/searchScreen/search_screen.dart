import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musiq/bloc/FeatchSong/featch_song_cubit.dart';
import 'package:musiq/core/colors.dart';
import 'package:musiq/main.dart';
import 'package:musiq/presentation/commanWidgets/textfeild.dart';
import 'package:musiq/presentation/screens/player_screen/player_screen.dart';
import 'package:musiq/presentation/screens/searchScreen/bloc/SearchSong/search_song_bloc.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  SearchScreenState createState() => SearchScreenState();
}

class SearchScreenState extends State<SearchScreen> {
  final FocusNode _focusNode = FocusNode();
  final TextEditingController _controller = TextEditingController();
  Timer? _debounce;

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
                  icon: const Icon(Icons.arrow_back),
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
                          if (songList.isNotEmpty) ...[
                            Text(
                              '   Songs',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: colorList[colorIndex]),
                            ),
                            ...songList.map((song) => ListTile(
                                  title: Text(song.album),
                                  subtitle: Text(song.artist),
                                  leading: Image.network(song.imageUrl),
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
                          if (searchResult.albums != null &&
                              searchResult.albums!.isNotEmpty) ...[
                            Text(
                              '   Albums',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: colorList[colorIndex]),
                            ),
                            ...searchResult.albums!.map((album) => ListTile(
                                  title: Text(album.album),
                                  subtitle: Text(album.artist),
                                  leading: Image.network(album.image),
                                  onTap: () {
                                    context.read<FeatchSongCubit>().clickSong(
                                        type: album.type,
                                        id: album.id,
                                        title: album.title);
                                  },
                                )),
                          ],
                          if (searchResult.playlists != null &&
                              searchResult.playlists!.isNotEmpty) ...[
                            Text(
                              '   Playlists',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: colorList[colorIndex]),
                            ),
                            ...searchResult.playlists!
                                .map((playlist) => ListTile(
                                      title: Text(playlist.title),
                                      subtitle: Text(playlist.artist),
                                      leading: Image.network(playlist.image),
                                      onTap: () {
                                        context
                                            .read<FeatchSongCubit>()
                                            .clickSong(
                                              type: playlist.type,
                                              id: playlist.id,
                                              title: playlist.title,
                                            );
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
