import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'progress_bar_state.dart';

class ProgressBarCubit extends Cubit<ProgressBarState> {
  ProgressBarCubit()
      : super(ProgressBarInitial(progressDuration: Duration.zero));

  changeProgress(Duration progress) {
    emit(ProgressBarInitial(progressDuration: progress));
  }

   void reset() {
    emit(ProgressBarInitial(progressDuration: Duration.zero));
  }
}
