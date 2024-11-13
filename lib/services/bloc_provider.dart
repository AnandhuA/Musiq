import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musiq/bloc/featchSong/featch_song_cubit.dart';
import 'package:musiq/bloc/ThemeCubit/theme_cubit.dart';
import 'package:musiq/bloc/Search/search_cubit.dart';
import 'package:musiq/bloc/favorite_bloc/favorite_bloc.dart';
import 'package:musiq/bloc/home_screen_cubit/home_screen_cubit.dart';
import 'package:musiq/bloc/playlist/play_list_cubit.dart';
import 'package:musiq/presentation/screens/loginScreen/bloc/login_bloc.dart';
import 'package:musiq/presentation/screens/player_screen/cubit/PlayAndPause/play_and_pause_cubit.dart';
import 'package:musiq/presentation/screens/player_screen/cubit/ProgressBar/progress_bar_cubit.dart';

class AppBlocProviders extends StatelessWidget {
  final Widget child;

  const AppBlocProviders({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ThemeCubit()),
        BlocProvider(create: (context) => LoginBloc()),
        BlocProvider(create: (context) => FavoriteBloc()),
        BlocProvider(create: (context) => ProgressBarCubit()),
        BlocProvider(create: (context) => PlayAndPauseCubit()),
        BlocProvider(create: (context) => HomeScreenCubit()),
        BlocProvider(create: (context) => FeatchSongCubit()),
        BlocProvider(create: (context) => SearchCubit()),
        BlocProvider(create: (context) => PlayListCubit()),
      ],
      child: child,
    );
  }
}
