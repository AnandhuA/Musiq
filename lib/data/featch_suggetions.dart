import 'dart:developer';

import 'package:http/http.dart' as http;

class FeatchSuggetions {
  static Future<http.Response?> featchSuggetions({required String url}) async {
    try {
      final response = await http
          .get(Uri.parse(url));
      return response;
    } catch (e) {
      log(e.toString());
      return null;
    }
  }
}
