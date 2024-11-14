import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:musiq/data/hive_funtions/last_played_repo.dart';
import 'package:musiq/data/savan_2.0.dart';
import 'package:musiq/models/home_screen_models/newHomeScreenModel.dart';
import 'package:musiq/models/song_model/song.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'home_screen_state.dart';

class HomeScreenCubit extends Cubit<HomeScreenState> {
  HomeScreenCubit() : super(HomeScreenInitial());

  Future<void> loadData() async {
    emit(HomeScreenLoading());
    final List<Song>? lastplayed = await LastPlayedRepo.fetchLastPlayed();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? cachedHomeScreenData =
        await prefs.getString('homeScreenData');

    final String? lastUpdated = await prefs.getString('lastUpdated');

    final DateTime now = await DateTime.now();
    final DateTime today = await DateTime(now.year, now.month, now.day);

    NewHomeScreenModel? newHomeScreenModel;

    if (lastUpdated != null) {
      final DateTime lastUpdateDate = DateTime.parse(lastUpdated);

      // Check if data was updated today
      if (lastUpdateDate.isAtSameMomentAs(today) &&
          cachedHomeScreenData != null) {
        // Load from cache
        newHomeScreenModel =
            NewHomeScreenModel.fromJson(jsonDecode(cachedHomeScreenData));

        log("---------load from cache----------");

        return emit(HomeScreenLoaded(
          newHomeScreenModel: newHomeScreenModel,
          lastPlayedSongList: lastplayed,
        ));
      }
    }

    // If no cache or cache is outdated, fetch new data

    final data = await Saavan2.featchHomeScreenModel();

    if (data != null && data.statusCode == 200) {
      final jsonData = jsonDecode(data.body);

      newHomeScreenModel = NewHomeScreenModel.fromJson(jsonData);
      log("-----------${newHomeScreenModel.songdata!.albums!.data!.first.image!.last.imageUrl}");

      // Cache the newHomeScreenModel
      prefs.setString('homeScreenData', data.body);
    } else if (cachedHomeScreenData != null) {
      newHomeScreenModel =
          NewHomeScreenModel.fromJson(jsonDecode(cachedHomeScreenData));
    }

    // Cache the last update date
    prefs.setString('lastUpdated', today.toIso8601String());

    // Emit the loaded state
    log("---------load from response ----------");
    return emit(HomeScreenLoaded(
      newHomeScreenModel: newHomeScreenModel,
      lastPlayedSongList: lastplayed,
    ));
  }
}
