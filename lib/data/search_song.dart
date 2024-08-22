import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:musiq/core/urls.dart';

class SearchSong {
  static Future<http.Response?> searchSong({required String data}) async {
    try {
      final response = await http.get(Uri.parse("$searchSongUrl$data&limit=70"));
      return response;
    } catch (e) {
      log(e.toString());
      return null;
    }
  }
}
