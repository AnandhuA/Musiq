import 'package:flutter/material.dart';
import 'package:musiq/models/song_model/song.dart';
import 'package:musiq/services/audio_handler.dart';

class AppGlobals {
  static final AppGlobals _instance = AppGlobals._internal();

  // Factory constructor to return the same instance
  factory AppGlobals() {
    return _instance;
  }

  // Private constructor to prevent external instantiation
  AppGlobals._internal();

  // Global variables
  String? theme;
  int colorIndex = 0;
  String? userIsLoggedIn;
  ValueNotifier<List<Song>> lastPlayedSongNotifier = ValueNotifier([]);
  late AudioPlayerHandler audioHandler;

  // You can add methods here to manipulate or retrieve the state if needed
  void updateTheme(String newTheme) {
    theme = newTheme;
  }

  void setColorIndex(int index) {
    colorIndex = index;
  }

  void setUserLoggedInStatus(String status) {
    userIsLoggedIn = status;
  }
}
