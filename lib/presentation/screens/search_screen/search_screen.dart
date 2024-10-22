import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musiq/bloc/Search/search_cubit.dart';

class NewSearchScreen extends StatelessWidget {
  NewSearchScreen({super.key});
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Search"),
      ),
      body: Column(
        children: [
          TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: "Search",
              border: OutlineInputBorder(),
            ),
            onChanged: (value) {
              context.read<SearchCubit>().searchGobal(query: value);
            },
          ),
        ],
      ),
    );
  }
}
