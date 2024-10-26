import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musiq/bloc/featchSong/featch_song_cubit.dart';
import 'package:musiq/bloc/Search/search_cubit.dart';
import 'package:musiq/core/colors.dart';
import 'package:musiq/core/global_variables.dart';
import 'package:musiq/core/sized.dart';
import 'package:musiq/presentation/screens/album_or_playlist_screen/album_or_playlist_screen.dart';
import 'package:musiq/presentation/screens/artist/artist_screen.dart';
import 'package:musiq/presentation/screens/player_screen/player_screen.dart';
import 'package:musiq/presentation/screens/search_screen/widgets/album_search_result.dart';
import 'package:musiq/presentation/screens/search_screen/widgets/all_search_result.dart';
import 'package:musiq/presentation/screens/search_screen/widgets/artist_search_result.dart';
import 'package:musiq/presentation/screens/search_screen/widgets/playlist_search_result.dart';
import 'package:musiq/presentation/screens/search_screen/widgets/song_search_result.dart';

class NewSearchScreen extends StatefulWidget {
  NewSearchScreen({super.key});

  @override
  State<NewSearchScreen> createState() => _NewSearchScreenState();
}

class _NewSearchScreenState extends State<NewSearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  Timer? _debounce;
  String _searchValue = "All";

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
// ---------------- listener --------------
      body: BlocListener<FeatchSongCubit, FeatchSongState>(
        listener: (context, state) {
// -------------- loading ------------------
          if (state is FeatchSongLoading) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) {
                return AlertDialog(
                  backgroundColor: Colors.transparent,
                  content: Center(
                    child: CircularProgressIndicator(
                      color: AppColors.colorList[AppGlobals().colorIndex],
                    ),
                  ),
                );
              },
            );
          }
//------------------- type is album or playlist ----------------
          else if (state is FeatchAlbumAndPlayListLoaded) {
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
          else if (state is FeatchSongByIDLoaded) {
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
          else if (state is FeatchArtistLoadedState) {
            Navigator.pop(context); //for closing loading
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ArtistScreen(model: state.model),
                ));
          }
        },
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: "Search",
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                onChanged: _onSearchChanged,
              ),
            ),
            AppSpacing.height20,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildButton("All", theme),
                _buildButton("Song", theme),
                _buildButton("Album", theme),
                _buildButton("Artist", theme),
                _buildButton("PlayList", theme),
              ],
            ),
            AppSpacing.height20,
            Expanded(
              child: _buildSearchResults(),
            ),
          ],
        ),
      ),
    );
  }

  // build widget based on the current value of "_searchValue"  -----

  Widget _buildSearchResults() {
    switch (_searchValue) {
      case "Song":
        return SongSearchResult();
      case "Album":
        return AlbumSearchResult();
      case "Artist":
        return ArtistSearchResult();
      case "PlayList":
        return PlaylistSearchResult();
      default:
        return AllSearchResult();
    }
  }

//--------  button  --------
  Widget _buildButton(String title, ThemeData theme) {
    return TextButton(
      onPressed: () {
        setState(() {
          _searchValue = title;
        });
        _onSearchChanged(_searchController.text);
      },
      child: Text(
        title,
        style: TextStyle(
          color: _searchValue == title
              ? AppColors.colorList[AppGlobals().colorIndex]
              : theme.brightness == Brightness.dark
                  ? AppColors.white
                  : AppColors.black,
        ),
      ),
      style: TextButton.styleFrom(
        backgroundColor: theme.brightness == Brightness.dark
            ? AppColors.white.withOpacity(0.1)
            : AppColors.black.withOpacity(0.1),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }

//--------- search funtion -------------
  void _onSearchChanged(String value) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();

    _debounce = Timer(const Duration(milliseconds: 500), () {
      switch (_searchValue) {
        case "Song":
          if (value.isNotEmpty)
            context.read<SearchCubit>().searchSong(query: value);
          break;
        case "Album":
          if (value.isNotEmpty)
            context.read<SearchCubit>().searchAlbum(query: value);
          break;
        case "Artist":
          if (value.isNotEmpty)
            context.read<SearchCubit>().searchArtist(query: value);
          break;
        case "PlayList":
          if (value.isNotEmpty)
            context.read<SearchCubit>().searchPlayList(query: value);
          break;
        case "All":
        default:
          if (value.isNotEmpty)
            context.read<SearchCubit>().searchGobal(query: value);
          break;
      }
    });
  }
}
