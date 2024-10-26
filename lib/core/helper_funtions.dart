import 'dart:math';

//get random number for Shuffle
int getRandomSongIndex({required List songList}) {
  final random = Random();
  return random.nextInt(songList.length);
}

//---error image ---------
String errorImage() {
  return "https://cdn.dribbble.com/users/3547568/screenshots/14395014/media/0b94c75b97182946d495f34c16eab987.jpg?resize=1000x750&vertical=center";
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
