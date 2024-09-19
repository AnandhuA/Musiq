import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musiq/main.dart';
import 'package:musiq/presentation/commanWidgets/custom_app_bar.dart';
import 'package:musiq/presentation/commanWidgets/favorite_icon.dart';
import 'package:musiq/presentation/screens/favoriteScreen/bloc/favorite_bloc.dart';
import 'package:musiq/presentation/screens/loginScreen/login_screen.dart';

class FavoriteScreen extends StatelessWidget {
  FavoriteScreen({super.key});
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(
          double.infinity,
          50,
        ),
        child: SearchAppBar(
          title: "Favorite",
          searchController: searchController,
          onSearchChanged: (value) {
            context.read<FavoriteBloc>().add(SearchFavoriteEvent(query: value));
          },
        ),
      ),
      body: userIsLoggedIn == null
          ? Center(
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginScreen(),
                      ));
                },
                child: const Text("LogIn"),
              ),
            )
          : BlocBuilder<FavoriteBloc, FavoriteState>(
              builder: (context, state) {
                if (state is FavoriteLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is FeatchFavoriteSuccess) {
                  return state.favorites.isEmpty
                      ? const Center(
                          child: Text("No Favorite"),
                        )
                      : ListView.builder(
                          itemCount: state.favorites.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              // onTap: () => Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (context) => PlayerScreen(
                              //       songs: state.favorites,
                              //       initialIndex: index,
                              //     ),
                              //   ),
                              // ),
                              trailing: FavoriteIcon(
                                song: state.favorites[index],
                              ),
                              leading: Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(
                                      state.favorites[index].imageUrl,
                                    ),
                                    fit: BoxFit.fill,
                                  ),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                              title: Text(
                                state.favorites[index].title,
                              ),
                              subtitle: Text(state.favorites[index].album),
                            );
                          },
                        );
                } else {
                  return const Center(
                    child: Text("error"),
                  );
                }
              },
            ),
    );
  }
}
