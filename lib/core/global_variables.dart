import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:musiq/models/song_model/song.dart';
import 'package:musiq/services/audio_handler.dart';

class AppGlobals {
  static final AppGlobals _instance = AppGlobals._internal();

  factory AppGlobals() {
    return _instance;
  }

  AppGlobals._internal();

  // Global variables
  String? theme;
  int colorIndex = 0;
  String? userIsLoggedIn;
  ValueNotifier<List<Song>> lastPlayedSongNotifier = ValueNotifier([]);
  late AudioPlayerHandler audioHandler;
  int currentSongIndex = 0;

  // You can add methods here to manipulate or retrieve the state if needed

  // Method to update the current song index
  void setCurrentSongIndex(int index) {
    log("----------updated $index");
    currentSongIndex = index;
  }



  void updateTheme(String? newTheme) {
    theme = newTheme;
  }

  void setColorIndex(int index) {
    colorIndex = index;
  }

  void setUserLoggedInStatus(String? status) {
    userIsLoggedIn = status;
  }
}
