import 'package:flutter/material.dart';
import 'package:musiq/bloc/favorite_bloc/favorite_bloc.dart';
import 'package:musiq/core/colors.dart';

class CustomAppBar extends StatelessWidget {
  final String title;
  const CustomAppBar({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox(
      height: 60,
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios_new_sharp,
              color: theme.brightness == Brightness.dark
                  ? AppColors.white
                  : AppColors.black,
            ),
          ),
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 25,
              ),
              maxLines: 1,
            ),
          ),
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.more_vert_sharp,
                color: theme.brightness == Brightness.dark
                    ? AppColors.white
                    : AppColors.black,
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
    required this.onSortSelected,
  });

  final String title;
  final TextEditingController searchController;
  final ValueChanged<String> onSearchChanged;
  final ValueChanged<SortOption> onSortSelected;

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
      automaticallyImplyLeading: false,
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(Icons.arrow_back_ios_new_sharp),
      ),
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
          ),
          onPressed: () {
            setState(() {
              _isSearching = !_isSearching;
              if (!_isSearching) {
                widget.searchController.clear();
                widget.onSearchChanged('');
              }
            });
          },
        ),
        PopupMenuButton<SortOption>(
          icon: Icon(
            Icons.filter_list_rounded,
          ),
          onSelected: (SortOption sortOption) {
            widget.onSortSelected(sortOption);
          },
          itemBuilder: (BuildContext context) {
            return [
              PopupMenuItem<SortOption>(
                value: SortOption(
                  key: 'name_asc',
                  sortType: SortType.name,
                  ascending: true,
                ),
                child: const Text('By Name (A-Z)'),
              ),
              PopupMenuItem<SortOption>(
                value: SortOption(
                  key: 'name_desc',
                  sortType: SortType.name,
                  ascending: false,
                ),
                child: const Text('By Name (Z-A)'),
              ),
              PopupMenuItem<SortOption>(
                value: SortOption(
                  key: 'time_asc',
                  sortType: SortType.time,
                  ascending: true,
                ),
                child: const Text('By Time (Newest)'),
              ),
              PopupMenuItem<SortOption>(
                value: SortOption(
                  key: 'time_desc',
                  sortType: SortType.time,
                  ascending: false,
                ),
                child: const Text('By Time (Oldest)'),
              ),
            ];
          },
        ),
      ],
    );
  }
}
