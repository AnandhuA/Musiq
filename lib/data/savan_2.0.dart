
import 'package:http/http.dart' as http;

class Saavan2 {
  static const String baseurl = "https://jiosaavn-api-rs.vercel.app/modules";
  static const String album = "https://jiosaavn-api-rs.vercel.app/album?id=";
  static const String playlist = "https://saavn.dev/api/playlists?id=";

  static Future<http.Response?> featchHomeScreenModel() async {
    try {
      final responce = await http.get(Uri.parse(baseurl));
      // log("status code${responce.statusCode}");
      // log("${responce.body}");
      return responce;
    } catch (e) {
      return null;
    }
  }

  static Future<http.Response?> featchAlbum({required String albumId}) async {
    try {
      final responce = await http.get(Uri.parse("$album$albumId"));
      // log("status code${responce.statusCode}");
      // log("${responce.body}");

      return responce;
    } catch (e) {
      return null;
    }
  }

  static Future<http.Response?> featchPlayList(
      {required String playlistId}) async {
    try {
      final responce = await http.get(Uri.parse("$playlist$playlistId"));

      // log("status code${responce.statusCode}");
      // log("${responce.body}");
      return responce;
    } catch (e) {
      return null;
    }
  }
}
