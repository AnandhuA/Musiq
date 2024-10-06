import 'package:flutter/material.dart';
import 'package:musiq/core/colors.dart';

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
          displayLarge:
              const TextStyle(fontFamily: 'LED-Dot-Matrix', color: black),
          displayMedium:
              const TextStyle(fontFamily: 'LED-Dot-Matrix', color: black),
          displaySmall:
              const TextStyle(fontFamily: 'LED-Dot-Matrix', color: black),
          headlineLarge:
              const TextStyle(fontFamily: 'LED-Dot-Matrix', color: black),
          headlineMedium:
              const TextStyle(fontFamily: 'LED-Dot-Matrix', color: black),
          headlineSmall:
              const TextStyle(fontFamily: 'LED-Dot-Matrix', color: black),
          titleLarge:
              const TextStyle(fontFamily: 'LED-Dot-Matrix', color: black),
          titleMedium:
              const TextStyle(fontFamily: 'LED-Dot-Matrix', color: black),
          titleSmall:
              const TextStyle(fontFamily: 'LED-Dot-Matrix', color: black),
          bodyLarge:
              const TextStyle(fontFamily: 'LED-Dot-Matrix', color: black),
          bodyMedium:
              const TextStyle(fontFamily: 'LED-Dot-Matrix', color: black),
          bodySmall:
              const TextStyle(fontFamily: 'LED-Dot-Matrix', color: black),
          labelLarge:
              const TextStyle(fontFamily: 'LED-Dot-Matrix', color: black),
          labelMedium:
              const TextStyle(fontFamily: 'LED-Dot-Matrix', color: black),
          labelSmall:
              const TextStyle(fontFamily: 'LED-Dot-Matrix', color: black),
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
          displayLarge:
              const TextStyle(fontFamily: 'LED-Dot-Matrix', color: white),
          displayMedium:
              const TextStyle(fontFamily: 'LED-Dot-Matrix', color: white),
          displaySmall:
              const TextStyle(fontFamily: 'LED-Dot-Matrix', color: white),
          headlineLarge:
              const TextStyle(fontFamily: 'LED-Dot-Matrix', color: white),
          headlineMedium:
              const TextStyle(fontFamily: 'LED-Dot-Matrix', color: white),
          headlineSmall:
              const TextStyle(fontFamily: 'LED-Dot-Matrix', color: white),
          titleLarge:
              const TextStyle(fontFamily: 'LED-Dot-Matrix', color: white),
          titleMedium:
              const TextStyle(fontFamily: 'LED-Dot-Matrix', color: white),
          titleSmall:
              const TextStyle(fontFamily: 'LED-Dot-Matrix', color: white),
          bodyLarge:
              const TextStyle(fontFamily: 'LED-Dot-Matrix', color: white),
          bodyMedium:
              const TextStyle(fontFamily: 'LED-Dot-Matrix', color: white),
          bodySmall:
              const TextStyle(fontFamily: 'LED-Dot-Matrix', color: white),
          labelLarge:
              const TextStyle(fontFamily: 'LED-Dot-Matrix', color: white),
          labelMedium:
              const TextStyle(fontFamily: 'LED-Dot-Matrix', color: white),
          labelSmall:
              const TextStyle(fontFamily: 'LED-Dot-Matrix', color: white),
        ),
  );
}
