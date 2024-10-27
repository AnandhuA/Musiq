import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:musiq/core/api_urls.dart';

class Saavan2 {
//------- ---------- featch home page data -------------
  static Future<http.Response?> featchHomeScreenModel() async {
    try {
      final responce = await http.get(Uri.parse(ApiUrls.homeData));
      return responce;
    } catch (e) {
      return null;
    }
  }

  //-------------------- featch song by id -----------------

  static Future<http.Response?> featchSong({required String songId}) async {
    try {
      final responce = await http.get(Uri.parse("${ApiUrls.song}$songId"));
      return responce;
    } catch (e) {
      return null;
    }
  }

// ------------------ featch album by id ------------------
  static Future<http.Response?> featchAlbum({required String albumId}) async {
    try {
      final responce = await http.get(Uri.parse("${ApiUrls.album}$albumId"));
      return responce;
    } catch (e) {
      return null;
    }
  }

// ----------------- featch play list from id ------------
  static Future<http.Response?> featchPlayList(
      {required String playlistId}) async {
    try {
      final responce =
          await http.get(Uri.parse("${ApiUrls.playlist}$playlistId"));
      return responce;
    } catch (e) {
      return null;
    }
  }

//--------------------featch artist by id -----------
  static Future<http.Response?> featchArtist({required String artistId}) async {
    try {
      final responce = await http.get(Uri.parse("${ApiUrls.artist}$artistId"));
      return responce;
    } catch (e) {
      log("${e.toString()}");
      return null;
    }
  }

// ---------------- search all ---------------
  static Future<http.Response?> featchglobalSearch(
      {required String query}) async {
    try {
      final response =
          await http.get(Uri.parse("${ApiUrls.globalSearch}$query"));
      return response;
    } catch (e) {
      return null;
    }
  }

// ---------------- search song -------------
  static Future<http.Response?> featchSearchSong(
      {required String query}) async {
    try {
      final response = await http.get(Uri.parse("${ApiUrls.searchSong}$query"));
      return response;
    } catch (e) {
      return null;
    }
  }

//--------------- search albums ---------------
  static Future<http.Response?> featchSearchAlbums(
      {required String query}) async {
    try {
      final response =
          await http.get(Uri.parse("${ApiUrls.searchAlbums}$query"));
      return response;
    } catch (e) {
      return null;
    }
  }

// -------------- search artists -----------------
  static Future<http.Response?> featchSearchArtists(
      {required String query}) async {
    try {
      final response =
          await http.get(Uri.parse("${ApiUrls.searchArtists}$query"));
      return response;
    } catch (e) {
      return null;
    }
  }

//------------------- search playlist -----------------
  static Future<http.Response?> featchSearchPlayList(
      {required String query}) async {
    try {
      final response =
          await http.get(Uri.parse("${ApiUrls.searchPlayList}$query"));
      return response;
    } catch (e) {
      return null;
    }
  }
}
