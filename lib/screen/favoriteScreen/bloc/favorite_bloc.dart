import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:musiq/firebase/functions/favorite_song_functions.dart';
import 'package:musiq/models/song.dart';

part 'favorite_event.dart';
part 'favorite_state.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  FavoriteBloc() : super(FavoriteInitial()) {
    on<FeatchFavoriteSongEvent>(_featchFavorite);
    on<AddFavoriteEvent>(_addFavorite);
    on<RemoveFavoriteEvent>(_removeFavorite);
  }

  FutureOr<void> _featchFavorite(
    FeatchFavoriteSongEvent event,
    Emitter<FavoriteState> emit,
  ) async {
    emit(FavoriteLoading());
    List<Song> songList =
        await FavoriteSongRepo.fetchFavorites();
    emit(FeatchFavoriteSuccess(favorites: songList));
  }

  FutureOr<void> _addFavorite(
    AddFavoriteEvent event,
    Emitter<FavoriteState> emit,
  ) async {
    emit(FavoriteLoading());

    final bool result = await FavoriteSongRepo.addFavorite(
    song: event.song
    );

    if (result) {
      log("set add");
      // add(FeatchFavoriteSongEvent());
    } else {
      log("not set");
      emit(FavoriteError());
    }
  }

  FutureOr<void> _removeFavorite(
    RemoveFavoriteEvent event,
    Emitter<FavoriteState> emit,
  ) async {
    emit(FavoriteLoading());
    final bool result = await FavoriteSongRepo.removeFavorite(
      songID: event.song.id ?? "1",
    );
    if (result) {
      log("set remove");
      // add(FeatchFavoriteSongEvent());
    } else {
      log("not set");
      emit(FavoriteError());
    }
  }
}
