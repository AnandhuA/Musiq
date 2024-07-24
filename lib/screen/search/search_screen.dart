import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musiq/core/sized.dart';
import 'package:musiq/screen/commanWidgets/textfeild.dart';
import 'package:musiq/screen/player_screen/player_screen.dart';
import 'package:musiq/screen/search/bloc/SearchSong/search_song_bloc.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  SearchScreenState createState() => SearchScreenState();
}

class SearchScreenState extends State<SearchScreen> {
  final FocusNode _focusNode = FocusNode();
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
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
                  log("onChanged: $value");
                },
                onSubmitted: (value) {
                  context
                      .read<SearchSongBloc>()
                      .add(SearchSongEvent(searchQuery: value));
                },
              ),
              constHeight10,
              Expanded(
                child: BlocBuilder<SearchSongBloc, SearchSongState>(
                  builder: (context, state) {
                    if (state is SearchSongLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is SearchSongSuccess) {
                      return state.searchResult.isEmpty
                          ? const Center(
                              child: Text("No Data"),
                            )
                          : ListView.separated(
                              separatorBuilder: (context, index) =>
                                  constHeight10,
                              itemCount: state.searchResult.length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  onTap: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => PlayerScreen(
                                          song: state.searchResult[index],
                                        ),
                                      )),
                                  leading: ClipRRect(
                                    borderRadius: BorderRadius.circular(5),
                                    child: Image.network(
                                      state.searchResult[index].image.first.url,
                                    ),
                                  ),
                                  title: Text(state.searchResult[index].name ??
                                      "no name"),
                                  subtitle: Text(
                                    state.searchResult[index].album.name,
                                  ),
                                  trailing: IconButton(
                                    onPressed: () {},
                                    icon: const Icon(
                                      Icons.favorite_border,
                                    ),
                                  ),
                                );
                              },
                            );
                    } else {
                      return const SizedBox();
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
