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
    textTheme: ThemeData.light().textTheme.copyWith(
          displayLarge: const TextStyle(fontFamily: 'LED-Dot-Matrix'),
          displayMedium: const TextStyle(fontFamily: 'LED-Dot-Matrix'),
          displaySmall: const TextStyle(fontFamily: 'LED-Dot-Matrix'),
          headlineLarge: const TextStyle(fontFamily: 'LED-Dot-Matrix'),
          headlineMedium: const TextStyle(fontFamily: 'LED-Dot-Matrix'),
          headlineSmall: const TextStyle(fontFamily: 'LED-Dot-Matrix'),
          titleLarge: const TextStyle(fontFamily: 'LED-Dot-Matrix'),
          titleMedium: const TextStyle(fontFamily: 'LED-Dot-Matrix'),
          titleSmall: const TextStyle(fontFamily: 'LED-Dot-Matrix'),
          bodyLarge: const TextStyle(fontFamily: 'LED-Dot-Matrix'),
          bodyMedium: const TextStyle(fontFamily: 'LED-Dot-Matrix'),
          bodySmall: const TextStyle(fontFamily: 'LED-Dot-Matrix'),
          labelLarge: const TextStyle(fontFamily: 'LED-Dot-Matrix'),
          labelMedium: const TextStyle(fontFamily: 'LED-Dot-Matrix'),
          labelSmall: const TextStyle(fontFamily: 'LED-Dot-Matrix'),
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
    textTheme: ThemeData.light().textTheme.copyWith(
          displayLarge: const TextStyle(fontFamily: 'LED-Dot-Matrix'),
          displayMedium: const TextStyle(fontFamily: 'LED-Dot-Matrix'),
          displaySmall: const TextStyle(fontFamily: 'LED-Dot-Matrix'),
          headlineLarge: const TextStyle(fontFamily: 'LED-Dot-Matrix'),
          headlineMedium: const TextStyle(fontFamily: 'LED-Dot-Matrix'),
          headlineSmall: const TextStyle(fontFamily: 'LED-Dot-Matrix'),
          titleLarge: const TextStyle(fontFamily: 'LED-Dot-Matrix'),
          titleMedium: const TextStyle(fontFamily: 'LED-Dot-Matrix'),
          titleSmall: const TextStyle(fontFamily: 'LED-Dot-Matrix'),
          bodyLarge: const TextStyle(fontFamily: 'LED-Dot-Matrix'),
          bodyMedium: const TextStyle(fontFamily: 'LED-Dot-Matrix'),
          bodySmall: const TextStyle(fontFamily: 'LED-Dot-Matrix'),
          labelLarge: const TextStyle(fontFamily: 'LED-Dot-Matrix'),
          labelMedium: const TextStyle(fontFamily: 'LED-Dot-Matrix'),
          labelSmall: const TextStyle(fontFamily: 'LED-Dot-Matrix'),
        ),
  );
}
