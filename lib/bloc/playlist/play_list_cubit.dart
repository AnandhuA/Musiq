import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:musiq/data/hive_funtions/playlist_repo.dart';
import 'package:musiq/models/playlist_model_hive/playlist_model.dart';
import 'package:musiq/models/song_model/song.dart';

part 'play_list_state.dart';

class PlayListCubit extends Cubit<PlayListState> {
  PlayListCubit() : super(PlayListInitial());

  void FetchPlayList() async {
    emit(PlayListLoadingState());
    List<PlaylistModelHive> list = await PlaylistRepo.fetchPlaylists();
    emit(FetchPlayListSuccessState(playlistList: list));
  }

  void addPlaylist(PlaylistModelHive playList) async {
    emit(PlayListLoadingState());
    await PlaylistRepo.addPlaylist(playList);
    FetchPlayList();
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
    FetchPlayList();
  }

  void removeSongFromPlayList(
      {required PlaylistModelHive playlist, required Song song}) async {
    emit(PlayListLoadingState());
    await PlaylistRepo.removeSongFromPlaylist(playlist.name, song);
    FetchPlayList();
  }
}
