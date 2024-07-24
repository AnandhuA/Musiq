import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musiq/screen/commanWidgets/textfeild.dart';
import 'package:musiq/screen/search/bloc/SearchSong/search_song_bloc.dart';
import 'package:musiq/screen/search/search_result_screen.dart';

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
                onChanged: (value) {
                  log("onChanged: $value");
                },
                onSubmitted: (value) {
                  context
                      .read<SearchSongBloc>()
                      .add(SearchSongEvent(searchQuery: value));
                },
              ),
              Expanded(child: BlocBuilder<SearchSongBloc, SearchSongState>(
                builder: (context, state) {
                  if (state is SearchSongLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is SearchSongSuccess) {
                    return ListView.builder(
                      itemCount: state.searchResult.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(state.searchResult
                                  [index].name
                              ),
                        );
                      },
                    );
                  } else {
                    return SizedBox();
                  }
                },
              ))
            ],
          ),
        ),
      ),
    );
  }
}
