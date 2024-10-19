import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:musiq/data/saavn_data.dart';
import 'package:musiq/data/savan_2.0.dart';
import 'package:musiq/models/home_screen_model.dart';
import 'package:musiq/models/home_screen_models/newHomeScreenModel.dart';
import 'package:musiq/models/song_model.dart';

part 'home_screen_state.dart';

class HomeScreenCubit extends Cubit<HomeScreenState> {
  HomeScreenCubit() : super(HomeScreenInitial());

  void loadData() async {
    emit(HomeScreenLoading());
    NewHomeScreenModel? newHomeScreenModel;
    final newData = await Saavan2.featchHomeScreenModel();
    final data = await SaavnAPI().fetchHomePageData();

    if (newData != null && newData.statusCode == 200) {
      final jsonData = jsonDecode(newData.body);
      newHomeScreenModel = NewHomeScreenModel.fromJson(jsonData);

      log("-----------${newHomeScreenModel.songdata!.albums!.data!.first.image!.last.imageUrl}");
    }

    final Map<String, dynamic> jsonData =
        data.map((key, value) => MapEntry(key.toString(), value));

    final HomeScreenModel homeScreenModel = HomeScreenModel.fromJson(jsonData);
    // final List<SongModel> lastplayed = await LastPlayedRepo.fetchLastPlayed();

    emit(HomeScreenLoaded(
      homeScreenModel: homeScreenModel,
      lastplayed: [],
      newHomeScreenModel: newHomeScreenModel,
    ));
  }
}
