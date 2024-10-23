import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musiq/bloc/Search/search_cubit.dart';
import 'package:musiq/core/colors.dart';
import 'package:musiq/core/global_variables.dart';
import 'package:musiq/presentation/commanWidgets/empty_screen.dart';

class AllSearchResult extends StatelessWidget {
  const AllSearchResult({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchCubit, SearchState>(
      builder: (context, state) {
        if (state is SearchLoadingState) {
          Center(
            child: CircularProgressIndicator(
              color: colorList[AppGlobals().colorIndex],
            ),
          );
        } else if (state is GobalSearchState) {
          ListView.builder(
            itemCount: state.model.data?.topQuery?.results?.length ?? 0,
            itemBuilder: (context, index) {
              final song = state.model.data?.topQuery?.results?[index];
              return ListTile(
                title: Text(song?.title ?? "No"),
              );
            },
          );
        }
        return emptyScreen(
          context: context,
          text1: "show",
          size1: 15,
          text2: "Nothing",
          size2: 20,
          text3: "All",
          size3: 20,
        );
      },
    );
  }
}
