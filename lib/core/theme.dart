import 'package:flutter/material.dart';

class ThemeClass {
  static ThemeData lightTheme = ThemeData.light().copyWith(
    brightness: Brightness.light,
    appBarTheme: const AppBarTheme(color: Colors.white),
    scaffoldBackgroundColor: Colors.white,
    drawerTheme: const DrawerThemeData(
      backgroundColor: Color.fromARGB(200, 255, 255, 255),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
    ),
  );

  static ThemeData darkTheme = ThemeData.dark().copyWith(
    brightness: Brightness.dark,
    appBarTheme: const AppBarTheme(color: Colors.black),
    scaffoldBackgroundColor: Colors.black,
    drawerTheme: const DrawerThemeData(
      backgroundColor: Color.fromARGB(200, 0, 0, 0),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.black,
    ),
  );
}
