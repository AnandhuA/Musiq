import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musiq/bloc/Search/search_cubit.dart';
import 'package:musiq/core/colors.dart';
import 'package:musiq/core/global_variables.dart';
import 'package:musiq/core/sized.dart';
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
      body: Column(
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
          context.read<SearchCubit>().searchSong(query: value);
          break;
        case "Album":
          context.read<SearchCubit>().searchAlbum(query: value);
          break;
        case "Artist":
          context.read<SearchCubit>().searchArtist(query: value);
          break;
        case "PlayList":
          context.read<SearchCubit>().searchPlayList(query: value);
          break;
        case "All":
        default:
          context.read<SearchCubit>().searchGobal(query: value);
          break;
      }
    });
  }
}
