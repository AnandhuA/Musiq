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
    String? imageUrl,
    required String title,
  }) {
    if (type == "song") {
      fetchSong(songId: id);
    } else if (type == "album") {
      featchAlbum(albumId: id, imageUrl: imageUrl, title: title);
    } else if (type == "playlist") {
      featchPlaylist(playlistId: id, imageUrl: imageUrl, title: title);
    } else if (type == "mix") {
      log("$id");
      featchPlaylist(playlistId: id, imageUrl: imageUrl, title: title);
    }
  }

//-----------is song----------
  void fetchSong({required String songId}) async {
    emit(FeatchSongLoading());
    final songData = await SaavnAPI().fetchSongDetails(songId);
    final SongModel songModel = SongModel.fromJson(songData);
    // log("${songModel.artist}");
    emit(FeatchSongLoaded(songModel: [songModel]));
  }

//------------ is album-------------

  void featchAlbum({
    required String albumId,
    String? imageUrl,
    required String title,
  }) async {
    emit(FeatchSongLoading());
    try {
      final albumData = await SaavnAPI().fetchAlbumSongs(albumId);
      // log("--------$albumData--------");
      List<SongModel> songList = (albumData['songs'] as List)
          .map((songJson) => SongModel.fromJson(songJson))
          .toList();

      emit(FeatchAlbumOrPlayList(
        songModel: songList,
        imageUrl: imageUrl,
        title: title,
      ));
    } catch (error) {
      log("Failed to fetch album: $error");
    }
  }
//--------- is playlist -------

  void featchPlaylist({
    required String playlistId,
    required String? imageUrl,
    required String title,
  }) async {
    emit(FeatchSongLoading());
    try {
      final playlistData = await SaavnAPI().fetchPlaylistSongs(playlistId);
      // log("$playlistData");
      List<SongModel> songList = (playlistData['songs'] as List)
          .map((songJson) => SongModel.fromJson(songJson))
          .toList();

      emit(FeatchAlbumOrPlayList(
          songModel: songList, imageUrl: imageUrl, title: title));
    } catch (error) {
      log("Failed to fetch playlist: $error");
    }
  }

//----------is artist ----------
  void feachArtistSong({
    required String artistName,
    required String imageUrl,
    required String title,
  }) async {
    emit(FeatchSongLoading());
    try {
      final songdata = await SaavnAPI()
          .fetchSongSearchResults(searchQuery: "$artistName songs", count: 50);

      List<SongModel> songList = (songdata['songs'] as List)
          .map((songJson) => SongModel.fromJson(songJson))
          .toList();
      emit(FeatchAlbumOrPlayList(
          songModel: songList, imageUrl: imageUrl, title: title));
      // log("${songdata}");
    } catch (e) {
      log("Failed to fetch playlist: $e");
    }
  }
}
