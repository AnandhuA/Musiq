import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:musiq/core/global_variables.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(ThemeInitial(theme: AppGlobals().theme));

  void chanheTheme({required String? theme}) {
    emit(ThemeInitial(theme: theme));
  }
}
