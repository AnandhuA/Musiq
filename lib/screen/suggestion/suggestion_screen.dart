import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musiq/bloc/Suggetions/suggestions_bloc.dart';
import 'package:musiq/models/song.dart';
import 'package:musiq/screen/suggestion/widgets/card_widget.dart';

class SuggestionScreen extends StatefulWidget {
  const SuggestionScreen({super.key});

  @override
  State<SuggestionScreen> createState() => _SuggestionScreenState();
}

class _SuggestionScreenState extends State<SuggestionScreen> {
  @override
  void initState() {
    context.read<SuggestionsBloc>().add(FetchSuggestionsEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Suggestion"),
      ),
      body: BlocBuilder<SuggestionsBloc, SuggestionsState>(
          builder: (context, state) {
        if (state is SuggestionsLoading) {
          const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is SuggestionsLoaded) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 5,
                crossAxisSpacing: 5,
                childAspectRatio: 0.8,
              ),
              itemCount: state.suggetionSongs.length,
              itemBuilder: (context, index) {
                Song song = state.suggetionSongs[index];
                return CardWidget(song: song);
              },
            ),
          );
        } else {
          return const Center(
            child: Text("error"),
          );
        }
      }),
    );
  }
}
