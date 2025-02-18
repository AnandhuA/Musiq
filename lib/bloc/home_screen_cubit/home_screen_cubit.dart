import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:musiq/data/hive_funtions/history_repo.dart';
import 'package:musiq/data/hive_funtions/playlist_repo.dart';
import 'package:musiq/data/savan_2.0.dart';
import 'package:musiq/models/home_screen_models/newHomeScreenModel.dart';
import 'package:musiq/models/playlist_model_hive/playlist_model.dart';
import 'package:musiq/models/song_model/song.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? cachedHomeScreenData =
        await prefs.getString('homeScreenData');
    final String? lastUpdated = await prefs.getString('lastUpdated');

    final DateTime now = await DateTime.now();
    final DateTime today = await DateTime(now.year, now.month, now.day);

    NewHomeScreenModel? newHomeScreenModel;

    // final Map<String, List> ytData = await ytService.getMusicHome();
    // log("ytdat ::::::${ytData} :::::::::::::");
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
          playList: playlist,
        ));
      }
    }

    // If no cache or cache is outdated, fetch new data

    final data = await Saavan2.fetchHomeScreenModel();

    if (data != null && data.statusCode == 200) {
      final jsonData = jsonDecode(data.body);

      newHomeScreenModel = NewHomeScreenModel.fromJson(jsonData);
      // Cache the last update date
      prefs.setString('lastUpdated', today.toIso8601String());
      prefs.setString('homeScreenData', data.body);
      // Emit the loaded state
      log("---------load from response ----------");
      return emit(HomeScreenLoaded(
        newHomeScreenModel: newHomeScreenModel,
        lastPlayedSongList: lastplayed,
        playList: playlist,
      ));

      // Cache the newHomeScreenModel
    } else if (cachedHomeScreenData != null) {
      if (defaultTargetPlatform != TargetPlatform.windows) {
        Fluttertoast.showToast(msg: "Load from cache");
      }
      newHomeScreenModel =
          NewHomeScreenModel.fromJson(jsonDecode(cachedHomeScreenData));
      return emit(HomeScreenLoaded(
        newHomeScreenModel: newHomeScreenModel,
        lastPlayedSongList: lastplayed,
        playList: playlist,
      ));
    } else if (data != null) {
      final Map<String, dynamic> jsonResponse = jsonDecode(jsonString);
      newHomeScreenModel = NewHomeScreenModel.fromJson(jsonResponse);
      if (defaultTargetPlatform != TargetPlatform.windows) {
        Fluttertoast.showToast(msg: "error::${data.statusCode}");
      }
      return emit(HomeScreenLoaded(
        newHomeScreenModel: newHomeScreenModel,
        lastPlayedSongList: lastplayed,
        playList: playlist,
      ));
    } else {
      final Map<String, dynamic> jsonResponse = jsonDecode(jsonString);
      newHomeScreenModel = NewHomeScreenModel.fromJson(jsonResponse);
      if (defaultTargetPlatform != TargetPlatform.windows) {
        Fluttertoast.showToast(msg: "Server Error");
      }
      return emit(HomeScreenLoaded(
        newHomeScreenModel: newHomeScreenModel,
        lastPlayedSongList: lastplayed,
        playList: playlist,
      ));
    }
  }
}
