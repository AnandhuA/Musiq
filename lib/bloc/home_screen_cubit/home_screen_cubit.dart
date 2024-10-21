import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:musiq/data/saavn_data.dart';
import 'package:musiq/data/savan_2.0.dart';
import 'package:musiq/models/home_screen_model.dart';
import 'package:musiq/models/home_screen_models/newHomeScreenModel.dart';
import 'package:musiq/models/song_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'home_screen_state.dart';

class HomeScreenCubit extends Cubit<HomeScreenState> {
  HomeScreenCubit() : super(HomeScreenInitial());

  Future<void> loadData() async {
    emit(HomeScreenLoading());

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? cachedHomeScreenData = prefs.getString('homeScreenData');
    final String? cachedNewHomeScreenData =
        prefs.getString('newHomeScreenData');
    final String? lastUpdated = prefs.getString('lastUpdated');

    final DateTime now = DateTime.now();
    final DateTime today = DateTime(now.year, now.month, now.day);
    // final List<SongModel> lastplayed = await LastPlayedRepo.fetchLastPlayed();

    if (lastUpdated != null) {
      final DateTime lastUpdateDate = DateTime.parse(lastUpdated);

      // Check if data was updated today
      if (lastUpdateDate.isAtSameMomentAs(today) &&
          cachedHomeScreenData != null &&
          cachedNewHomeScreenData != null) {
        // Load from cache
        final homeScreenModel =
            HomeScreenModel.fromJson(jsonDecode(cachedHomeScreenData));
        final newHomeScreenModel =
            NewHomeScreenModel.fromJson(jsonDecode(cachedNewHomeScreenData));

        log("---------load from cache----------");
        emit(HomeScreenLoaded(
          homeScreenModel: homeScreenModel,
          lastplayed: [],
          newHomeScreenModel: newHomeScreenModel,
        ));
        return;
      }
    }

    // If no cache or cache is outdated, fetch new data
    NewHomeScreenModel? newHomeScreenModel;
    final newData = await Saavan2.featchHomeScreenModel();
    final data = await SaavnAPI().fetchHomePageData();

    if (newData != null && newData.statusCode == 200) {
      final jsonData = jsonDecode(newData.body);
      newHomeScreenModel = NewHomeScreenModel.fromJson(jsonData);
      log("-----------${newHomeScreenModel.songdata!.albums!.data!.first.image!.last.imageUrl}");

      // Cache the newHomeScreenModel
      prefs.setString('newHomeScreenData', newData.body);
    }

    final Map<String, dynamic> jsonData =
        data.map((key, value) => MapEntry(key.toString(), value));

    final HomeScreenModel homeScreenModel = HomeScreenModel.fromJson(jsonData);

    // Cache the homeScreenModel
    prefs.setString('homeScreenData', jsonEncode(homeScreenModel));

    // Cache the last update date
    prefs.setString('lastUpdated', today.toIso8601String());

    // Emit the loaded state
    log("---------load from response ----------");
    emit(HomeScreenLoaded(
      homeScreenModel: homeScreenModel,
      lastplayed: [],
      newHomeScreenModel: newHomeScreenModel,
    ));
  }
}
