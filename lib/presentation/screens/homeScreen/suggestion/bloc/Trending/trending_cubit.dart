import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:musiq/core/urls.dart';
import 'package:musiq/data/featch_suggetions.dart';
import 'package:musiq/models/song.dart';

part 'trending_state.dart';

class TrendingCubit extends Cubit<TrendingState> {
  TrendingCubit() : super(TrendingInitial());

  void fetchTrendingSongs() async {
    emit(TrendingLoading());
    final Response? suggetionResponce =
        await FeatchSuggetions.featchSuggetions(url: trendingSongsUrl);

    if (suggetionResponce != null) {
      final Map<String, dynamic> decodedSuggetionResponse =
          jsonDecode(suggetionResponce.body);
      if (decodedSuggetionResponse["data"]['results'] != null) {
        switch (suggetionResponce.statusCode) {
          case 200:
            final List<Song> suggetionSongs =
                (decodedSuggetionResponse['data']['results'] as List)
                    .map((songJson) => Song.fromJson(songJson))
                    .toList();
            emit(TrendingLoaded(songs: suggetionSongs));

            break;

          default:
        }
      } else {
        emit(TrendingError());
      }
    }else{
       emit(TrendingError());
    }
  }
}
