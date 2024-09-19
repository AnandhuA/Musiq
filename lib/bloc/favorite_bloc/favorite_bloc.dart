import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:musiq/data/favorite_song_functions.dart';
import 'package:musiq/models/song_model.dart';

part 'favorite_event.dart';
part 'favorite_state.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  List<SongModel> _favorites = [];
  FavoriteBloc() : super(FavoriteInitial()) {
    on<FeatchFavoriteSongEvent>(_featchFavorite);
    on<AddFavoriteEvent>(_addFavorite);
    on<RemoveFavoriteEvent>(_removeFavorite);
    on<SearchFavoriteEvent>(_searchFavorite);
  }

  FutureOr<void> _featchFavorite(
    FeatchFavoriteSongEvent event,
    Emitter<FavoriteState> emit,
  ) async {
    emit(FavoriteLoading());
    _favorites = await FavoriteSongRepo.fetchFavorites();
    emit(FeatchFavoriteSuccess(favorites: _favorites));
  }

  FutureOr<void> _addFavorite(
    AddFavoriteEvent event,
    Emitter<FavoriteState> emit,
  ) async {
    emit(FavoriteLoading());
    _favorites.add(event.song);
    FavoriteSongRepo.addFavorite(song: event.song);
    emit(FeatchFavoriteSuccess(favorites: _favorites));
  }

  FutureOr<void> _removeFavorite(
    RemoveFavoriteEvent event,
    Emitter<FavoriteState> emit,
  ) async {
    emit(FavoriteLoading());
    _favorites.remove(event.song);
    FavoriteSongRepo.removeFavorite(
      songID: event.song.id,
    );
    emit(FeatchFavoriteSuccess(favorites: _favorites));
  }

  FutureOr<void> _searchFavorite(
    SearchFavoriteEvent event,
    Emitter<FavoriteState> emit,
  ) {
    emit(FavoriteLoading());

    final query = event.query.toLowerCase();
    final filteredFavorites = _favorites
        .where((song) => song.id.toLowerCase().contains(query))
        .toList();

    emit(FeatchFavoriteSuccess(favorites: filteredFavorites));
  }
}