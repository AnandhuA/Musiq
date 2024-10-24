import 'dart:math';
import 'package:musiq/models/home_screen_model.dart';

//---------- get songs ------------
List<dynamic> getAllSongs(HomeScreenModel homeScreenModel) {
  List<dynamic> allSongs = [];

  allSongs
      .addAll(homeScreenModel.newTrending.where((item) => item.type == 'song'));
  allSongs.addAll(homeScreenModel.charts.where((item) => item.type == 'song'));
  allSongs.addAll(
      homeScreenModel.topPlaylists.where((item) => item.type == 'song'));
  allSongs
      .addAll(homeScreenModel.tagMixes.where((item) => item.type == 'song'));
  allSongs
      .addAll(homeScreenModel.artistRecos.where((item) => item.type == 'song'));
  allSongs
      .addAll(homeScreenModel.newAlbums.where((item) => item.type == 'song'));
  return allSongs;
}

//get random number for Shuffle
int getRandomSongIndex({required List songList}) {
  final random = Random();
  return random.nextInt(songList.length);
}

//---error image ---------
String errorImage() {
  return "https://e7.pngegg.com/pngimages/945/333/png-clipart-music-songwriter-logo-art-AppColors.black-miscellaneous-text-thumbnail.png";
}

// --- find error from status code ------
class StatusCodeHandler {
  String getErrorMessage(int statusCode) {
    if (statusCode >= 100 && statusCode < 200) {
      return 'Informational response: $statusCode';
    } else if (statusCode >= 300 && statusCode < 400) {
      return 'Redirection: $statusCode';
    } else if (statusCode >= 400 && statusCode < 500) {
      return 'Client error: $statusCode';
    } else if (statusCode >= 500 && statusCode < 600) {
      return 'Server error: $statusCode';
    } else {
      return 'Unknown status code: $statusCode';
    }
  }
}
