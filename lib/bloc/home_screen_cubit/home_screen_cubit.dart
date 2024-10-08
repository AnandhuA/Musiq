import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:musiq/data/hive_funtion.dart';
import 'package:musiq/data/saavn_data.dart';
import 'package:musiq/models/home_screen_model.dart';
import 'package:musiq/models/song_model.dart';

part 'home_screen_state.dart';

class HomeScreenCubit extends Cubit<HomeScreenState> {
  HomeScreenCubit() : super(HomeScreenInitial());

  void loadData() async {
    emit(HomeScreenLoading());

    final data = await SaavnAPI().fetchHomePageData();

    final Map<String, dynamic> jsonData =
        data.map((key, value) => MapEntry(key.toString(), value));

    final HomeScreenModel homeScreenModel = HomeScreenModel.fromJson(jsonData);
    final List<SongModel> lastplayed = await LastPlayedRepo.fetchLastPlayed();

    emit(HomeScreenLoaded(
      homeScreenModel: homeScreenModel,
      lastplayed: lastplayed,
    ));
  }
}
