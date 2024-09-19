import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';

import 'package:musiq/data/format.dart';

Future<Map> formatHomePageData(Map data) async {
  try {
    if (data['new_trending'] != null) {
      data['new_trending'] = await formatSongsInList(
        data['new_trending'] as List,
        fetchDetails: false,
      );
    }
    if (data['new_albums'] != null) {
      data['new_albums'] = await formatSongsInList(
        data['new_albums'] as List,
        fetchDetails: false,
      );
    }
    if (data['city_mod'] != null) {
      data['city_mod'] = await formatSongsInList(
        data['city_mod'] as List,
        fetchDetails: true,
      );
    }
    final List promoList = [];
    final List promoListTemp = [];
    data['modules'].forEach((k, v) {
      if (k.startsWith('promo') as bool) {
        if (data[k][0]['type'] == 'song' &&
            (data[k][0]['mini_obj'] as bool? ?? false)) {
          promoListTemp.add(k.toString());
        } else {
          promoList.add(k.toString());
        }
      }
    });
    for (int i = 0; i < promoList.length; i++) {
      data[promoList[i]] = await formatSongsInList(
        data[promoList[i]] as List,
        fetchDetails: false,
      );
    }
    data['collections'] = [
      'new_trending',
      'charts',
      'new_albums',
      'top_playlists',
      'radio',
      'city_mod',
      'artist_recos',
      ...promoList
    ];
    data['collections_temp'] = promoListTemp;
  } catch (e) {
    print('Error in formatHomePageData: $e');
  }
  return data;
}

Future<List> formatSongsInList(
  List list, {
  required bool fetchDetails,
}) async {
  if (list.isNotEmpty) {
    for (int i = 0; i < list.length; i++) {
      final Map item = list[i] as Map;
      if (item['type'] == 'song') {
        if (item['mini_obj'] as bool? ?? false) {
          continue;
        }
        list[i] = await formatSingleSongResponse(item);
      }
    }
  }
  list.removeWhere((value) => value == null);
  return list;
}

//------------------

Future<Map> formatSingleSongResponse(Map response) async {

  try {
    final List artistNames = [];
    if (response['more_info']?['artistMap']?['primary_artists'] == null ||
        response['more_info']?['artistMap']?['primary_artists'].length == 0) {
      if (response['more_info']?['artistMap']?['featured_artists'] == null ||
          response['more_info']?['artistMap']?['featured_artists'].length ==
              0) {
        if (response['more_info']?['artistMap']?['artists'] == null ||
            response['more_info']?['artistMap']?['artists'].length == 0) {
          artistNames.add('Unknown');
        } else {
          try {
            response['more_info']['artistMap']['artists'][0]['id']
                .forEach((element) {
              artistNames.add(element['name']);
            });
          } catch (e) {
            response['more_info']['artistMap']['artists'].forEach((element) {
              artistNames.add(element['name']);
            });
          }
        }
      } else {
        response['more_info']['artistMap']['featured_artists']
            .forEach((element) {
          artistNames.add(element['name']);
        });
      }
    } else {
      response['more_info']['artistMap']['primary_artists'].forEach((element) {
        artistNames.add(element['name']);
      });
    }

    return {
      'id': response['id'],
      'type': response['type'],
      'album': response['more_info']['album'].toString(),
      'year': response['year'],
      'duration': response['more_info']['duration'],
      'language': response['language'].toString(),
      'genre': response['language'].toString(),
      '320kbps': response['more_info']['320kbps'],
      'has_lyrics': response['more_info']['has_lyrics'],
      'lyrics_snippet': response['more_info']['lyrics_snippet'].toString(),
      'release_date': response['more_info']['release_date'],
      'album_id': response['more_info']['album_id'],
      'subtitle': response['subtitle'].toString(),
      'title': response['title'].toString(),
      'artist': artistNames.join(', '),
      'album_artist': response['more_info'] == null
          ? response['music']
          : response['more_info']['music'],
      'image': response['image']
          .toString()
          .replaceAll('150x150', '500x500')
          .replaceAll('50x50', '500x500')
          .replaceAll('http:', 'https:'),
      'perma_url': response['perma_url'],
      'url': decode(response['more_info']['encrypted_media_url'].toString()),
    };
  } catch (e) {

    return {'Error': e};
  }
}

String decode(String input) {
  const String key = '38346591';
  final DES desECB = DES(key: key.codeUnits);

  final Uint8List encrypted = base64.decode(input);
  final List<int> decrypted = desECB.decrypt(encrypted);
  final String decoded =
      utf8.decode(decrypted).replaceAll(RegExp(r'\.mp4.*'), '.mp4');
  return decoded.replaceAll('http:', 'https:');
}

Future<List<Map>> formatAlbumResponse(
  List responseList,
  String type,
) async {
  final List<Map> searchedAlbumList = [];
  for (int i = 0; i < responseList.length; i++) {
    Map? response;
    switch (type) {
      case 'album':
        response = await formatSingleAlbumResponse(responseList[i] as Map);
        break;
      case 'artist':
        response = await formatSingleArtistResponse(responseList[i] as Map);
        break;
      case 'playlist':
        response = await formatSinglePlaylistResponse(responseList[i] as Map);
        break;
      case 'show':
        response = await formatSingleShowResponse(responseList[i] as Map);
        break;
    }
    if (response!.containsKey('Error')) {
      log('Error at index $i inside FormatAlbumResponse: ${response["Error"]}');
    } else {
      searchedAlbumList.add(response);
    }
  }
  return searchedAlbumList;
}

Future<Map> formatSingleAlbumResponse(Map response) async {
  try {
    return {
      'id': response['id'],
      'type': response['type'],
      'album': response['title'].toString(),
      'year': response['more_info']?['year'] ?? response['year'],
      'language': response['more_info']?['language'] == null
          ? response['language'].toString()
          : response['more_info']['language'].toString(),
      'genre': response['more_info']?['language'] == null
          ? response['language'].toString()
          : response['more_info']['language'].toString(),
      'album_id': response['id'],
      'subtitle': response['description'] == null
          ? response['subtitle'].toString()
          : response['description'].toString(),
      'title': response['title'].toString(),
      'artist': response['music'] == null
          ? (response['more_info']?['music']) == null
              ? (response['more_info']?['artistMap']?['primary_artists'] ==
                          null ||
                      (response['more_info']?['artistMap']?['primary_artists']
                              as List)
                          .isEmpty)
                  ? ''
                  : response['more_info']['artistMap']['primary_artists'][0]
                          ['name']
                      .toString()
              : response['more_info']['music'].toString()
          : response['music'].toString(),
      'album_artist': response['more_info'] == null
          ? response['music']
          : response['more_info']['music'],
      'image': response['image']
          .toString()
          .replaceAll('150x150', '500x500')
          .replaceAll('50x50', '500x500')
          .replaceAll('http:', 'https:'),
      'count': response['more_info']?['song_pids'] == null
          ? 0
          : response['more_info']['song_pids'].toString().split(', ').length,
      'songs_pids': response['more_info']['song_pids'].toString().split(', '),
      'perma_url': response['url'].toString(),
    };
  } catch (e) {
    log('Error inside formatSingleAlbumResponse: $e');
    return {'Error': e};
  }
}

Future<Map> formatSingleArtistResponse(Map response) async {
  try {
    return {
      'id': response['id'],
      'type': response['type'],
      'album': response['title'] == null
          ? response['name'].toString()
          : response['title'].toString(),
      'language': response['language'].toString(),
      'genre': response['language'].toString(),
      'artistId': response['id'],
      'artistToken': response['url'] == null
          ? response['perma_url'].toString().split('/').last
          : response['url'].toString().split('/').last,
      'subtitle': response['description'] == null
          ? response['role'].toString()
          : response['description'].toString(),
      'title': response['title'] == null
          ? response['name'].toString()
          : response['title'].toString(),
      // .split('(')
      // .first
      'perma_url': response['url'].toString(),
      'artist': response['title'].toString(),
      'album_artist': response['more_info'] == null
          ? response['music']
          : response['more_info']['music'],
      'image': response['image']
          .toString()
          .replaceAll('150x150', '500x500')
          .replaceAll('50x50', '500x500')
          .replaceAll('http:', 'https:'),
    };
  } catch (e) {
    log('Error inside formatSingleArtistResponse: $e');
    return {'Error': e};
  }
}

Future<Map> formatSinglePlaylistResponse(Map response) async {
  try {
    return {
      'id': response['id'],
      'type': response['type'],
      'album': response['title'].toString(),
      'language': response['language'] == null
          ? response['more_info']['language'].toString()
          : response['language'].toString(),
      'genre': response['language'] == null
          ? response['more_info']['language'].toString()
          : response['language'].toString(),
      'playlistId': response['id'],
      'subtitle': response['description'] == null
          ? response['subtitle'].toString()
          : response['description'].toString(),
      'title': response['title'].toString(),
      'artist': response['extra'].toString(),
      'album_artist': response['more_info'] == null
          ? response['music']
          : response['more_info']['music'],
      'image': response['image']
          .toString()
          .replaceAll('150x150', '500x500')
          .replaceAll('50x50', '500x500')
          .replaceAll('http:', 'https:'),
      'perma_url': response['url'].toString(),
    };
  } catch (e) {
    log('Error inside formatSinglePlaylistResponse: $e');
    return {'Error': e};
  }
}

Future<Map> formatSingleShowResponse(Map response) async {
  try {
    return {
      'id': response['id'],
      'type': response['type'],
      'album': response['title'].toString(),
      'subtitle': response['description'] == null
          ? response['subtitle'].toString()
          : response['description'].toString(),
      'title': response['title'].toString(),
      'image': response['image']
          .toString()
          .replaceAll('150x150', '500x500')
          .replaceAll('50x50', '500x500')
          .replaceAll('http:', 'https:'),
    };
  } catch (e) {
    return {'Error': e};
  }
}


Future<List> formatSongsResponse(
  List responseList,
  String type,
) async {
  final List searchedList = [];
  for (int i = 0; i < responseList.length; i++) {
    Map? response;
    switch (type) {
      case 'song':
      case 'album':
      case 'playlist':
        response = await formatSingleSongResponse(responseList[i] as Map);
        break;
      default:
        break;
    }

    if (response!.containsKey('Error')) {
      log('Error at index $i inside FormatSongsResponse: ${response["Error"]}');
    } else {
      searchedList.add(response);
    }
  }
  return searchedList;
}
