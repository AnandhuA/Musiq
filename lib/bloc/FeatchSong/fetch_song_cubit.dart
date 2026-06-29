import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:meta/meta.dart';
import 'package:musiq/data/yt_services/youtube_service.dart';
import 'package:musiq/data/yt_services/yt_music_data.dart';
import 'package:musiq/models/album_model/album_model.dart';
import 'package:musiq/models/artist_model/artist_model.dart';
import 'package:musiq/models/play_list_model/play_list_model.dart';
import 'package:musiq/models/song_model/song.dart';

part 'fetch_song_state.dart';

class FetchSongCubit extends Cubit<FetchSongState> {
  FetchSongCubit() : super(FetchSongInitial());
//------- check funtion by type -----------
  void fetchData(
      {required String type,
      required String id,
      required String imageUrl,
      Song? song}) {
    log("type::$type id::$id");
    switch (type.toLowerCase()) {
      case 'song':
      case 'video':
        fetchSongById(id: id, song: song);
        break;
      default:
        emit(FetchSongError(
          error: "Only YouTube music tracks are supported now",
        ));
    }
  }

//-------- Fetch album by id --------------
  void fetchAlbum({required String id, required String imageUrl}) async {
    emit(FetchSongError(error: "YouTube album view is not available yet"));
  }

//----------Fetch playlist by id ---------------
  void fetchPlayList({required String id, required String imageUrl}) async {
    emit(FetchSongError(error: "YouTube playlist view is not available yet"));
  }

//---------- Fetch Artis by id ------------
  void FetchArtistSongs({required String id, required String imageUrl}) async {
    emit(FetchSongError(error: "YouTube artist view is not available yet"));
  }

//---------- Fetch song by id ------------
  void fetchSongById({required String id, Song? song}) async {
    log("----youtube song");
    emit(FetchSongLoading());
    try {
      final metadata = song?.toJson();
      final quality = Hive.box('settings')
          .get(
            'ytQuality',
            defaultValue: 'Low',
          )
          .toString();
      Map? data = await YtMusicService().getSongData(
        videoId: id,
        data: metadata,
        quality: quality,
      );
      if (data == null ||
          data.isEmpty ||
          (data['urlsData'] as List?)?.isEmpty == true) {
        if (song != null) {
          data = await YouTubeServices.instance.formatSongFromStreams(
            id: id,
            song: song,
            quality: quality,
          );
        }
      }
      if (data == null ||
          data.isEmpty ||
          (data['urlsData'] as List?)?.isEmpty == true) {
        data = await YouTubeServices.instance.formatVideoFromId(
          id: id,
          data: metadata,
        );
      }
      if (data == null || data.isEmpty) {
        emit(FetchSongError(error: "Unable to load YouTube stream"));
        return;
      }
      final Song playableSong = Song.fromJson(Map<String, dynamic>.from(data));
      if (playableSong.downloadUrl == null ||
          playableSong.downloadUrl!.isEmpty) {
        emit(FetchSongError(error: "No playable YouTube audio stream found"));
        return;
      }
      emit(FetchSongByIDLoaded(songs: [playableSong]));
    } catch (e, stackTrace) {
      log("YouTube stream error", error: e, stackTrace: stackTrace);
      emit(FetchSongError(error: "YouTube error: $e"));
    }
  }
}
