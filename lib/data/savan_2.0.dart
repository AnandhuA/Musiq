import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:musiq/core/api_urls.dart';

class Saavan2 {
//------- ---------- Fetch home page data -------------
  static Future<http.Response?> fetchHomeScreenModel() async {
    log("Fetching home screen data...");
    try {
      final response = await http.get(
        Uri.parse(ApiUrls.homeData),
        headers: {
          'Content-Type': 'application/json',
          'User-Agent': 'Mozilla/5.0 (compatible; MyApp/1.0)',
        },
      ).timeout(
        const Duration(seconds: 10),
        onTimeout: () {
          log("Request timed out");
          return http.Response('Request timeout', 408); // HTTP 408: Timeout
        },
      );
      return response;
    } catch (e) {
      log("error$e");
      return null;
    }
  }

  //-------------------- fetch song by id -----------------

  static Future<http.Response?> fetchSong({required String songId}) async {
    try {
      final responce = await http.get(Uri.parse("${ApiUrls.song}$songId"));
      return responce;
    } catch (e) {
      return null;
    }
  }

// ------------------ fetch album by id ------------------
  static Future<http.Response?> fetchAlbum({required String albumId}) async {
    try {
      final responce = await http.get(Uri.parse(ApiUrls.album(albumId)));
      return responce;
    } catch (e) {
      return null;
    }
  }

// ----------------- fetch play list from id ------------
  static Future<http.Response?> fetchPlayList(
      {required String playlistId}) async {
    try {
      final responce = await http.get(Uri.parse(ApiUrls.playlist(playlistId)));
      return responce;
    } catch (e) {
      return null;
    }
  }

//--------------------fetch artist by id -----------
  static Future<http.Response?> fetchArtist({required String artistId}) async {
    try {
      final responce = await http.get(Uri.parse(ApiUrls.artist(artistId)));
      return responce;
    } catch (e) {
      log("${e.toString()}");
      return null;
    }
  }

// ---------------- search all ---------------
  static Future<http.Response?> fetchglobalSearch(
      {required String query}) async {
    try {
      final response = await http.get(Uri.parse(ApiUrls.globalSearch(query)));
      return response;
    } catch (e) {
      return null;
    }
  }

// ---------------- search song -------------
  static Future<http.Response?> fetchSearchSong({required String query}) async {
    try {
      final response = await http.get(Uri.parse(ApiUrls.searchSong(query)));
      return response;
    } catch (e) {
      return null;
    }
  }

//--------------- search albums ---------------
  static Future<http.Response?> fetchSearchAlbums(
      {required String query}) async {
    try {
      final response = await http.get(Uri.parse(ApiUrls.searchAlbums(query)));
      return response;
    } catch (e) {
      return null;
    }
  }

// -------------- search artists -----------------
  static Future<http.Response?> fetchSearchArtists(
      {required String query}) async {
    try {
      final response = await http.get(Uri.parse(ApiUrls.searchArtists(query)));
      return response;
    } catch (e) {
      return null;
    }
  }

//------------------- search playlist -----------------
  static Future<http.Response?> fetchSearchPlayList(
      {required String query}) async {
    try {
      final response = await http.get(Uri.parse(ApiUrls.searchPlayList(query)));
      return response;
    } catch (e) {
      return null;
    }
  }
}
