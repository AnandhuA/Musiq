import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:musiq/data/hive_funtions/playlist_repo.dart';
import 'package:musiq/models/playlist_model_hive/playlist_model.dart';
import 'package:musiq/models/song_model/song.dart';

part 'play_list_state.dart';

class PlayListCubit extends Cubit<PlayListState> {
  PlayListCubit() : super(PlayListInitial());

  void featchPlayList() async {
    emit(PlayListLoadingState());
    List<PlaylistModelHive> list = await PlaylistRepo.fetchPlaylists();
    emit(FeatchPlayListSuccessState(playlistList: list));
  }

  void addPlaylist(PlaylistModelHive playList) async {
    emit(PlayListLoadingState());
    await PlaylistRepo.addPlaylist(playList);
    featchPlayList();
  }

  void addSongToPlayList({
    required PlaylistModelHive playlistModel,
    required Song songModel,
  }) async {
    await PlaylistRepo.addSongToPlaylist(playlistModel.name, songModel);
  }

  void deletePlaylist({required PlaylistModelHive playlist}) async {
    emit(PlayListLoadingState());
    await PlaylistRepo.deletePlaylist(playlist.name);
    featchPlayList();
  }
}
