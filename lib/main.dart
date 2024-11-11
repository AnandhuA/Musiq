import 'dart:developer';

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
import 'package:permission_handler/permission_handler.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await requestStoragePermission();
  runApp(const MyApp());
}

Future<void> requestStoragePermission() async {
  log("------------permission-----------");

  var status = await Permission.storage.status;

  log("status::$status");

  if (status.isDenied) {
    await Permission.storage.request();
  } else if (status.isPermanentlyDenied) {
  } else if (status.isGranted) {
    log("Storage permission granted.");
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AppInitializer _appInitializer = AppInitializer();

  @override
  void initState() {
    super.initState();
    _appInitializer.initializeApp(context);
  }

  @override
  void dispose() {
    _appInitializer.dispose();
    super.dispose();
  }

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
