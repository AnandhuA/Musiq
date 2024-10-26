import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:musiq/data/savan_2.0.dart';
import 'package:musiq/models/home_screen_models/newHomeScreenModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'home_screen_state.dart';

class HomeScreenCubit extends Cubit<HomeScreenState> {
  HomeScreenCubit() : super(HomeScreenInitial());

  Future<void> loadData() async {
    emit(HomeScreenLoading());

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? cachedHomeScreenData = prefs.getString('homeScreenData');

    final String? lastUpdated = prefs.getString('lastUpdated');

    final DateTime now = DateTime.now();
    final DateTime today = DateTime(now.year, now.month, now.day);
    // final List<Song> lastplayed = await LastPlayedRepo.fetchLastPlayed();

    if (lastUpdated != null) {
      final DateTime lastUpdateDate = DateTime.parse(lastUpdated);

      // Check if data was updated today
      if (lastUpdateDate.isAtSameMomentAs(today) &&
          cachedHomeScreenData != null) {
        // Load from cache

        final newHomeScreenModel =
            NewHomeScreenModel.fromJson(jsonDecode(cachedHomeScreenData));

        log("---------load from cache----------");
        emit(HomeScreenLoaded(
          newHomeScreenModel: newHomeScreenModel,
        ));
        return;
      }
    }

    // If no cache or cache is outdated, fetch new data
    NewHomeScreenModel? newHomeScreenModel;
    final data = await Saavan2.featchHomeScreenModel();

    if (data != null && data.statusCode == 200) {
      final jsonData = jsonDecode(data.body);
      newHomeScreenModel = NewHomeScreenModel.fromJson(jsonData);
      log("-----------${newHomeScreenModel.songdata!.albums!.data!.first.image!.last.imageUrl}");

      // Cache the newHomeScreenModel
      prefs.setString('homeScreenData', data.body);
    }

    // Cache the last update date
    prefs.setString('lastUpdated', today.toIso8601String());

    // Emit the loaded state
    log("---------load from response ----------");
    emit(HomeScreenLoaded(
      newHomeScreenModel: newHomeScreenModel,
    ));
  }
}
