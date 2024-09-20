import 'package:flutter/material.dart';
import 'package:musiq/core/colors.dart';
import 'package:musiq/main.dart';

class CustomAppBar extends StatelessWidget {
  final String title;
  const CustomAppBar({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios_new_sharp),
          ),
          Expanded(
              child: Text(
            title,
            style: const TextStyle(
              fontSize: 25,
            ),
            maxLines: 1,
          ))
        ],
      ),
    );
  }
}

class SearchAppBar extends StatefulWidget implements PreferredSizeWidget {
  const SearchAppBar({
    super.key,
    required this.title,
    required this.searchController,
    required this.onSearchChanged,
  });

  final String title;
  final TextEditingController searchController;
  final ValueChanged<String> onSearchChanged;

  @override
  SearchAppBarState createState() => SearchAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class SearchAppBarState extends State<SearchAppBar> {
  bool _isSearching = false;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: _isSearching
          ? TextField(
              controller: widget.searchController,
              decoration: const InputDecoration(
                hintText: 'Search...',
                border: InputBorder.none,
              ),
              autofocus: true,
              onChanged: (value) {
                widget.onSearchChanged(value);
              },
            )
          : Text(widget.title),
      actions: [
        IconButton(
          icon: Icon(
            _isSearching ? Icons.close : Icons.search,
            color: colorList[colorIndex],
          ),
          onPressed: () {
            setState(() {
              _isSearching = !_isSearching;
              if (!_isSearching) {
                widget.searchController.clear();
                widget.onSearchChanged(''); // Clear search when closing
              }
            });
          },
        ),
      ],
    );
  }
}
