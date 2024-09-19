import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';
import 'package:musiq/data/responce_format.dart';

class SaavnAPI {
//--------- urls -------------------
  String baseUrl = 'www.jiosaavn.com';
  String apiStr = '/api.php?_format=json&_marker=0&api_version=4&ctx=web6dot0';
//--------languages ---------------
  List<String> preferredLanguages = ['Malayalam', 'Tamil', 'Hindi', 'English'];
//---------End points -----------
  Map<String, String> endpoints = {
    'homeData': '__call=webapi.getLaunchData',
    'topSearches': '__call=content.getTopSearches',
    'fromToken': '__call=webapi.get',
    'featuredRadio': '__call=webradio.createFeaturedStation',
    'artistRadio': '__call=webradio.createArtistStation',
    'entityRadio': '__call=webradio.createEntityStation',
    'radioSongs': '__call=webradio.getSong',
    'songDetails': '__call=song.getDetails',
    'playlistDetails': '__call=playlist.getDetails',
    'albumDetails': '__call=content.getAlbumDetails',
    'getResults': '__call=search.getResults',
    'albumResults': '__call=search.getAlbumResults',
    'artistResults': '__call=search.getArtistResults',
    'playlistResults': '__call=search.getPlaylistResults',
    'getReco': '__call=reco.getreco',
    'getAlbumReco': '__call=reco.getAlbumReco',
    'artistOtherTopSongs': '__call=search.artistOtherTopSongs',
  };
//------------header------------
  Map<String, String> headers = {
    'Accept': '*/*',
    'User-Agent': 'Mozilla/5.0',
  };

//----------- responce ---------------
  Future<http.Response> getResponse(
    String params, {
    bool usev4 = true,
    bool useProxy = false,
  }) async {
    Uri url;
    if (!usev4) {
      url = Uri.https(
        baseUrl,
        '$apiStr&$params'.replaceAll('&api_version=4', ''),
      );
    } else {
      url = Uri.https(baseUrl, '$apiStr&$params');
    }
    preferredLanguages =
        preferredLanguages.map((lang) => lang.toLowerCase()).toList();
    final String languageHeader = 'L=${preferredLanguages.join('%2C')}';
    headers = {'cookie': languageHeader, 'Accept': '*/*'};

    if (useProxy) {
      final proxyIP = '192.168.1.1';
      final proxyPort = '8080';
      final HttpClient httpClient = HttpClient();
      httpClient.findProxy = (uri) {
        return 'PROXY $proxyIP:$proxyPort;';
      };
      httpClient.badCertificateCallback =
          (X509Certificate cert, String host, int port) => Platform.isAndroid;
      final IOClient myClient = IOClient(httpClient);
      return myClient.get(url, headers: headers);
    }
    return http.get(url, headers: headers).onError((error, stackTrace) {
      return http.Response(error.toString(), 404);
    });
  }

//-------- fetch home page data --------------------
  Future<Map> fetchHomePageData() async {
    Map result = {};
    try {
      final res = await getResponse(endpoints['homeData']!);
      if (res.statusCode == 200) {
        final Map data = json.decode(res.body) as Map;
        result = await formatHomePageData(data);
        return result;
      }
    } catch (e) {
      print('Error in fetchHomePageData: $e');
    }
    return result;
  }

//-----------featch song --------------------
  Future<Map> fetchSongDetails(String songId) async {
    final String params = 'pids=$songId&${endpoints["songDetails"]}';
    try {
      final res = await getResponse(params);
      if (res.statusCode == 200) {
        final Map data = json.decode(res.body) as Map;
        final map = await formatSingleSongResponse(
          data['songs'][0] as Map,
        );
        print("--------------------------$map");
        return map;
      }
    } catch (e) {
      print('Error in fetchSongDetails: $e');
    }
    return {};
  }

// ------------- featch album songs --------------

  Future<List<Map>> fetchAlbums({
    required String searchQuery,
    required String type,
    int count = 30,
    int page = 1,
  }) async {
    String? params;
    if (type == 'playlist') {
      params =
          'p=$page&q=$searchQuery&n=$count&${endpoints["playlistResults"]}';
    }
    if (type == 'album') {
      params = 'p=$page&q=$searchQuery&n=$count&${endpoints["albumResults"]}';
    }
    if (type == 'artist') {
      params = 'p=$page&q=$searchQuery&n=$count&${endpoints["artistResults"]}';
    }

    final res = await getResponse(params!);
    if (res.statusCode == 200) {
      final getMain = json.decode(res.body);
      final List responseList = getMain['results'] as List;
      return formatAlbumResponse(responseList, type);
    }
    return List.empty();
  }

  Future<Map> fetchAlbumSongs(String albumId) async {
    final String params = '${endpoints['albumDetails']}&cc=in&albumid=$albumId';
    try {
      final res = await getResponse(params);
      if (res.statusCode == 200) {
        final getMain = json.decode(res.body);
        final List responseList = getMain['list'] as List;
        return {
          'songs': await formatSongsResponse(responseList, 'album'),
          'error': '',
        };
      } else {
        return {
          'songs': List.empty(),
          'error': res.body,
        };
      }
    } catch (e) {
      log('Error in fetchAlbumSongs: $e');
      return {
        'songs': List.empty(),
        'error': e,
      };
    }
  }

//----------- featch playlist --------------------

  Future<Map> fetchPlaylistSongs(String playlistId) async {
    final String params =
        '${endpoints["playlistDetails"]}&cc=in&listid=$playlistId';
    try {
      final res = await getResponse(params);
      if (res.statusCode == 200) {
        final getMain = json.decode(res.body);
        if (getMain['list'] != '') {
          final List responseList = getMain['list'] as List;
          return {
            'songs': await formatSongsResponse(
              responseList,
              'playlist',
            ),
            'error': '',
          };
        }
        return {
          'songs': List.empty(),
          'error': '',
        };
      } else {
        return {
          'songs': List.empty(),
          'error': res.body,
        };
      }
    } catch (e) {
      log('Error in fetchPlaylistSongs: $e');
      return {
        'songs': List.empty(),
        'error': e,
      };
    }
  }

//-------------------artist ----------

  Future<List> getReco(String pid) async {
    final String params = "${endpoints['getReco']}&pid=$pid";
    final res = await getResponse(params);
    log("----${res.body}");
    if (res.statusCode == 200) {
      // final List getMain = json.decode(res.body) as List;
      // return formatSongsResponse(getMain, 'song');
    }
    return List.empty();
  }

//------------ radio--------

  Future<List> getRadioSongs({
    required String stationId,
    int count = 20,
    int next = 1,
  }) async {
    if (count > 0) {
      final String params =
          "stationid=$stationId&k=$count&next=$next&${endpoints['radioSongs']}";
      final res = await getResponse(params);
      log("----${res.body}");
      if (res.statusCode == 200) {
        final Map getMain = json.decode(res.body) as Map;
        final List responseList = [];
        for (int i = 0; i < count; i++) {
          responseList.add(getMain[i.toString()]['song']);
        }
        return formatSongsResponse(responseList, 'song');
      }
      return [];
    }
    return [];
  }

//-------------------- search relsult --------------------

  Future<List<Map>> fetchSearchResults(String searchQuery) async {
    final Map<String, List> result = {};
    final Map<int, String> position = {};
    List searchedAlbumList = [];
    List searchedPlaylistList = [];
    List searchedArtistList = [];
    List searchedTopQueryList = [];

    final String params =
        '__call=autocomplete.get&cc=in&includeMetaTags=1&query=$searchQuery';

    final res = await getResponse(params, usev4: false, useProxy: false);
    // log("search --${res.body}");
    if (res.statusCode == 200) {
      final getMain = json.decode(res.body);
      final List albumResponseList = getMain['albums']['data'] as List;
      position[getMain['albums']['position'] as int] = 'Albums';

      final List playlistResponseList = getMain['playlists']['data'] as List;
      position[getMain['playlists']['position'] as int] = 'Playlists';

      final List artistResponseList = getMain['artists']['data'] as List;
      position[getMain['artists']['position'] as int] = 'Artists';

      final List topQuery = getMain['topquery']['data'] as List;

      searchedAlbumList = await formatAlbumResponse(albumResponseList, 'album');
      if (searchedAlbumList.isNotEmpty) {
        result['Albums'] = searchedAlbumList;
      }

      searchedPlaylistList = await formatAlbumResponse(
        playlistResponseList,
        'playlist',
      );
      if (searchedPlaylistList.isNotEmpty) {
        result['Playlists'] = searchedPlaylistList;
      }

      searchedArtistList = await formatAlbumResponse(
        artistResponseList,
        'artist',
      );
      if (searchedArtistList.isNotEmpty) {
        result['Artists'] = searchedArtistList;
      }

      if (topQuery.isNotEmpty &&
          (topQuery[0]['type'] != 'playlist' ||
              topQuery[0]['type'] == 'artist' ||
              topQuery[0]['type'] == 'album')) {
        position[getMain['topquery']['position'] as int] = 'Top Result';
        position[getMain['songs']['position'] as int] = 'Songs';

        switch (topQuery[0]['type'] as String) {
          case 'artist':
            searchedTopQueryList =
                await formatAlbumResponse(topQuery, 'artist');
            break;
          case 'album':
            searchedTopQueryList = await formatAlbumResponse(topQuery, 'album');
            break;
          case 'playlist':
            searchedTopQueryList =
                await formatAlbumResponse(topQuery, 'playlist');
            break;
          default:
            break;
        }
        if (searchedTopQueryList.isNotEmpty) {
          result['Top Result'] = searchedTopQueryList;
        }
      } else {
        if (topQuery.isNotEmpty && topQuery[0]['type'] == 'song') {
          position[getMain['topquery']['position'] as int] = 'Songs';
        } else {
          position[getMain['songs']['position'] as int] = 'Songs';
        }
      }
    }
    // log("${[result, position]}");
    return [result, position];
  }

//------------top search --------------
  Future<List<String>> getTopSearches() async {
    try {
      final res = await getResponse(endpoints['topSearches']!, useProxy: true);
      // log("${res.body}");
      if (res.statusCode == 200) {
        final List getMain = json.decode(res.body) as List;
        return getMain.map((element) {
          return element['title'].toString();
        }).toList();
      }
    } catch (e) {
      log('Error in getTopSearches: $e');
    }
    return List.empty();
  }

//-------------featch song search --------------------
  Future<Map> fetchSongSearchResults({
    required String searchQuery,
    int count = 20,
    int page = 1,
  }) async {
    final String params =
        "p=$page&q=$searchQuery&n=$count&${endpoints['getResults']}";

    try {
      final res = await getResponse(params, useProxy: false);
      if (res.statusCode == 200) {
        final Map getMain = json.decode(res.body) as Map;
        final List responseList = getMain['results'] as List;
        return {
          'songs': await formatSongsResponse(responseList, 'song'),
          'error': '',
        };
      } else {
        return {
          'songs': List.empty(),
          'error': res.body,
        };
      }
    } catch (e) {
      log('Error in fetchSongSearchResults: $e');
      return {
        'songs': List.empty(),
        'error': e,
      };
    }
  }
}








//------------------------------------------------------------------------------
