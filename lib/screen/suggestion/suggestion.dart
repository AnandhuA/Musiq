import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musiq/bloc/Suggetions/suggestions_bloc.dart';
import 'package:musiq/screen/player_screen/player_screen.dart';
import 'package:musiq/screen/suggestion/widgets/card_widget.dart';

class Suggestion extends StatefulWidget {
  const Suggestion({super.key});

  @override
  State<Suggestion> createState() => _SuggestionState();
}

class _SuggestionState extends State<Suggestion> {
  @override
  void initState() {
    context.read<SuggestionsBloc>().add(FetchSuggestionsEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocBuilder<SuggestionsBloc, SuggestionsState>(
            builder: (context, state) {
          if (state is SuggestionsLoading) {
            const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is SuggestionsLoaded) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "   Malayalam Songs",
                  style: TextStyle(fontSize: 20),
                ),
                const SizedBox(height: 10),
                Container(
                  height: 200,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) => InkWell(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PlayerScreen(
                            song: state.suggetionSongs[index],
                          ),
                        ),
                      ),
                      child: CardWidget(
                        song: state.suggetionSongs[index],
                      ),
                    ),
                    itemCount: state.suggetionSongs.length,
                  ),
                ),
              ],
            );
          } else {
            return Center(
              child: Text("error$state"),
            );
          }
        }),
      ],
    );
  }
}
