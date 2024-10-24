import 'package:flutter/material.dart';
import 'package:musiq/core/colors.dart';

class ThemeClass {
  static ThemeData lightTheme = ThemeData.light().copyWith(
    brightness: Brightness.light,
    appBarTheme: const AppBarTheme(color: AppColors.white),
    scaffoldBackgroundColor: AppColors.white,
    drawerTheme: const DrawerThemeData(
        backgroundColor: Color.fromARGB(200, 255, 255, 255)),
    bottomNavigationBarTheme:
        const BottomNavigationBarThemeData(backgroundColor: AppColors.white),
    textTheme: ThemeData.light().textTheme.copyWith(
          displayLarge: const TextStyle(
              fontFamily: 'LED-Dot-Matrix', color: AppColors.black),
          displayMedium: const TextStyle(
              fontFamily: 'LED-Dot-Matrix', color: AppColors.black),
          displaySmall: const TextStyle(
              fontFamily: 'LED-Dot-Matrix', color: AppColors.black),
          headlineLarge: const TextStyle(
              fontFamily: 'LED-Dot-Matrix', color: AppColors.black),
          headlineMedium: const TextStyle(
              fontFamily: 'LED-Dot-Matrix', color: AppColors.black),
          headlineSmall: const TextStyle(
              fontFamily: 'LED-Dot-Matrix', color: AppColors.black),
          titleLarge: const TextStyle(
              fontFamily: 'LED-Dot-Matrix', color: AppColors.black),
          titleMedium: const TextStyle(
              fontFamily: 'LED-Dot-Matrix', color: AppColors.black),
          titleSmall: const TextStyle(
              fontFamily: 'LED-Dot-Matrix', color: AppColors.black),
          bodyLarge: const TextStyle(
              fontFamily: 'LED-Dot-Matrix', color: AppColors.black),
          bodyMedium: const TextStyle(
              fontFamily: 'LED-Dot-Matrix', color: AppColors.black),
          bodySmall: const TextStyle(
              fontFamily: 'LED-Dot-Matrix', color: AppColors.black),
          labelLarge: const TextStyle(
              fontFamily: 'LED-Dot-Matrix', color: AppColors.black),
          labelMedium: const TextStyle(
              fontFamily: 'LED-Dot-Matrix', color: AppColors.black),
          labelSmall: const TextStyle(
              fontFamily: 'LED-Dot-Matrix', color: AppColors.black),
        ),
  );

  static ThemeData darkTheme = ThemeData.dark().copyWith(
    brightness: Brightness.dark,
    appBarTheme: const AppBarTheme(color: AppColors.black),
    scaffoldBackgroundColor: AppColors.black,
    drawerTheme:
        const DrawerThemeData(backgroundColor: Color.fromARGB(200, 0, 0, 0)),
    bottomNavigationBarTheme:
        const BottomNavigationBarThemeData(backgroundColor: AppColors.black),
    textTheme: ThemeData.light().textTheme.copyWith(
          displayLarge: const TextStyle(
              fontFamily: 'LED-Dot-Matrix', color: AppColors.white),
          displayMedium: const TextStyle(
              fontFamily: 'LED-Dot-Matrix', color: AppColors.white),
          displaySmall: const TextStyle(
              fontFamily: 'LED-Dot-Matrix', color: AppColors.white),
          headlineLarge: const TextStyle(
              fontFamily: 'LED-Dot-Matrix', color: AppColors.white),
          headlineMedium: const TextStyle(
              fontFamily: 'LED-Dot-Matrix', color: AppColors.white),
          headlineSmall: const TextStyle(
              fontFamily: 'LED-Dot-Matrix', color: AppColors.white),
          titleLarge: const TextStyle(
              fontFamily: 'LED-Dot-Matrix', color: AppColors.white),
          titleMedium: const TextStyle(
              fontFamily: 'LED-Dot-Matrix', color: AppColors.white),
          titleSmall: const TextStyle(
              fontFamily: 'LED-Dot-Matrix', color: AppColors.white),
          bodyLarge: const TextStyle(
              fontFamily: 'LED-Dot-Matrix', color: AppColors.white),
          bodyMedium: const TextStyle(
              fontFamily: 'LED-Dot-Matrix', color: AppColors.white),
          bodySmall: const TextStyle(
              fontFamily: 'LED-Dot-Matrix', color: AppColors.white),
          labelLarge: const TextStyle(
              fontFamily: 'LED-Dot-Matrix', color: AppColors.white),
          labelMedium: const TextStyle(
              fontFamily: 'LED-Dot-Matrix', color: AppColors.white),
          labelSmall: const TextStyle(
              fontFamily: 'LED-Dot-Matrix', color: AppColors.white),
        ),
  );
}
