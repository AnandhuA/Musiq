import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';

import 'package:musiq/main.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(ThemeInitial(theme: theme));

  void chanheTheme({required String? theme}) {
    emit(ThemeInitial(theme: theme));
  }
}
