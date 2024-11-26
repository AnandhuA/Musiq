import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musiq/core/firebase_options.dart';
import 'package:musiq/core/global_variables.dart';
import 'package:musiq/core/theme.dart';
import 'package:musiq/bloc/ThemeCubit/theme_cubit.dart';
import 'package:musiq/presentation/screens/splashScreen/splash_screen.dart';
import 'package:musiq/services/app_initializer.dart';
import 'package:musiq/services/bloc_provider.dart';

void main() async {
  final AppInitializer _appInitializer = AppInitializer();

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  _appInitializer.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return AppBlocProviders(
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          if (state is ThemeInitial) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              home: const SplashScreen(),
              theme: ThemeClass.lightTheme,
              darkTheme: ThemeClass.darkTheme,
              themeMode: state.theme == null || state.theme == "System"
                  ? ThemeMode.system
                  : state.theme == 'Light'
                      ? ThemeMode.light
                      : ThemeMode.dark,
            );
          }
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: const SplashScreen(),
            theme: ThemeClass.lightTheme,
            darkTheme: ThemeClass.darkTheme,
            themeMode:
                AppGlobals().theme == null || AppGlobals().theme == "System"
                    ? ThemeMode.system
                    : AppGlobals().theme == 'Light'
                        ? ThemeMode.light
                        : ThemeMode.dark,
          );
        },
      ),
    );
  }
}
