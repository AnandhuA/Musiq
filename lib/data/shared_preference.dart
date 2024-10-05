
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreference {
  static const String themeKey = "THEME_KEY";
  static const String color = "COLOR_KEY";
  static const String currentSongKey = "CURRENT_SONG_KEY";

  static setTheme({required String theme}) async {
    final sharedPref = await SharedPreferences.getInstance();
    await sharedPref.setString(themeKey, theme);
  }

  static Future<String?> getTheme() async {
    final sharedPref = await SharedPreferences.getInstance();
    final theme = sharedPref.getString(themeKey);
    return theme;
  }

  static setColorIndex({required int colorIndex}) async {
    final sharedPref = await SharedPreferences.getInstance();
    await sharedPref.setInt(color, colorIndex);
  }

  static Future<int?> getColorIndex() async {
    final sharedPref = await SharedPreferences.getInstance();
    final index = sharedPref.getInt(color);
    return index;
  }

  static Future<void> clearAllPreferences() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear(); // This removes all the stored preferences
  }
}
