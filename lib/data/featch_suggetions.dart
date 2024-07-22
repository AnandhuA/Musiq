import 'dart:developer';

import 'package:http/http.dart' as http;

class FeatchSuggetions {
  static Future<http.Response?> featchSuggetions() async {
    try {
      final response = await http
          .get(Uri.parse('https://saavn.dev/api/songs/wBgCQQ_6/suggestions'));
      return response;
    } catch (e) {
      log(e.toString());
      return null;
    }
  }
}
