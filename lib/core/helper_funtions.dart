import 'dart:math';

import 'package:musiq/models/home_screen_model.dart';

List<dynamic> getAllSongs(HomeScreenModel homeScreenModel) {
  List<dynamic> allSongs = [];

  allSongs.addAll(
    homeScreenModel.newTrending.where((item) => item.type == 'song'),
  );
  allSongs.addAll(
    homeScreenModel.charts.where((item) => item.type == 'song'),
  );
  allSongs.addAll(
    homeScreenModel.topPlaylists.where((item) => item.type == 'song'),
  );
  allSongs.addAll(
    homeScreenModel.tagMixes.where((item) => item.type == 'song'),
  );
  allSongs.addAll(
    homeScreenModel.artistRecos.where((item) => item.type == 'song'),
  );
  allSongs.addAll(
    homeScreenModel.newAlbums.where((item) => item.type == 'song'),
  );
  return allSongs;
}

int getRandomSongIndex({required List songList}) {
  final random = Random();
  return random.nextInt(songList.length);
}

String errorImage() {
  return "https://e7.pngegg.com/pngimages/945/333/png-clipart-music-songwriter-logo-art-black-miscellaneous-text-thumbnail.png";
}
