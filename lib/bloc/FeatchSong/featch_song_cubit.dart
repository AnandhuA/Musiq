import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:musiq/data/saavn_data.dart';
import 'package:musiq/models/song_model.dart';

part 'featch_song_state.dart';

class FeatchSongCubit extends Cubit<FeatchSongState> {
  FeatchSongCubit() : super(FeatchSongInitial());

  void clickSong({
    required String type,
    required String id,
  }) {
    if (type == "song") {
      fetchSong(songId: id);
    } else if (type == "album") {
      featchAlbum(albumId: id);
    } else if (type == "playlist") {
      featchPlaylist(playlistId: id);
    } else if (type == "mix") {
      log("$id");
      SaavnAPI().fetchSearchResults(id);
    }
  }

//-----------is song----------
  void fetchSong({required String songId}) async {
    emit(FeatchSongLoading());
    final songData = await SaavnAPI().fetchSongDetails(songId);
    final SongModel songModel = SongModel.fromJson(songData);
    log("${songModel.artist}");
    emit(FeatchSongLoaded(songModel: [songModel]));
  }

//------------ is album-------------
  void featchAlbum({required String albumId}) async {
    try {
      final albumData = await SaavnAPI().fetchAlbumSongs(albumId);
      log("$albumData");
      List<SongModel> songList = (albumData['songs'] as List)
          .map((songJson) => SongModel.fromJson(songJson))
          .toList();

      emit(FeatchSongLoaded(songModel: songList));
    } catch (error) {
      log("Failed to fetch album: $error");
    }
  }
//--------- is playlist -------

  void featchPlaylist({required String playlistId}) async {
    try {
      final playlistData = await SaavnAPI().fetchPlaylistSongs(playlistId);
      log("$playlistData");
      List<SongModel> songList = (playlistData['songs'] as List)
          .map((songJson) => SongModel.fromJson(songJson))
          .toList();

      emit(FeatchSongLoaded(songModel: songList));
    } catch (error) {
      log("Failed to fetch playlist: $error");
    }
  }
}
