import 'package:shared_preferences/shared_preferences.dart';

class SharedPreference {
  static const String themeKey = "THEME_KEY";
  static const String accentColor = "ACCENT_COLOR_KEY";

  static setTheme({required String theme}) async {
    final sharedPref = await SharedPreferences.getInstance();
    await sharedPref.setString(themeKey, theme);
  }

  static Future<String?> getTheme() async {
    final sharedPref = await SharedPreferences.getInstance();
    final theme = sharedPref.getString(themeKey);
    return theme;
  }

  static setAccentColorIndex({required int accentColorIndex}) async {
    final sharedPref = await SharedPreferences.getInstance();
    await sharedPref.setInt(accentColor, accentColorIndex);
  }

  static Future<int?> getAccentColorIndex() async {
    final sharedPref = await SharedPreferences.getInstance();
    final index = sharedPref.getInt(accentColor);
    return index;
  }
}