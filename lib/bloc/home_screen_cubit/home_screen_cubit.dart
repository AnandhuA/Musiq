import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:musiq/data/hive_funtions/history_repo.dart';
import 'package:musiq/data/hive_funtions/playlist_repo.dart';
import 'package:musiq/models/home_screen_models/newHomeScreenModel.dart';
import 'package:musiq/models/playlist_model_hive/playlist_model.dart';
import 'package:musiq/models/song_model/song.dart';

part 'home_screen_state.dart';

class HomeScreenCubit extends Cubit<HomeScreenState> {
  HomeScreenCubit() : super(HomeScreenInitial());

  Future<void> loadData() async {
    emit(HomeScreenLoading());
    // final YouTubeServices ytService = YouTubeServices.instance;
    String jsonString =
        await rootBundle.loadString('assets/local_data/sample.json');
    final List<Song>? lastplayed = await HistoryRepo.fetchLastPlayed();
    final List<PlaylistModelHive>? playlist =
        await PlaylistRepo.fetchPlaylists();
    final Map<String, dynamic> jsonResponse = jsonDecode(jsonString);
    final newHomeScreenModel = NewHomeScreenModel.fromJson(jsonResponse);
    return emit(HomeScreenLoaded(
      newHomeScreenModel: newHomeScreenModel,
      lastPlayedSongList: lastplayed,
      playList: playlist,
    ));
  }
}
