import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musiq/core/sized.dart';
import 'package:musiq/main.dart';
import 'package:musiq/screen/settings/ThemeCubit/theme_cubit.dart';
import 'package:musiq/screen/settings/widgets/list_tile_widget.dart';
import 'package:musiq/utils/sharedPreference/shared_preference.dart';

class ThemeScreen extends StatefulWidget {
  const ThemeScreen({super.key});

  @override
  State<ThemeScreen> createState() => _ThemeScreenState();
}

class _ThemeScreenState extends State<ThemeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          ListTileWidget(
            icon: const Icon(Icons.system_update),
            title: "System",
            onTap: () {
              setState(() {
                SharedPreference.setTheme(theme: "System");
                theme = "System";
                context.read<ThemeCubit>().chanheTheme(theme: theme);
              });
            },
            endWidget: theme == "System" || theme == null
                ? const CircleAvatar(
                    radius: 12,
                    child: Icon(
                      Icons.check,
                      size: 15,
                    ),
                  )
                : const SizedBox(),
          ),
          constHeight20,
          MultiListTileWidget(
            icon1: const Icon(Icons.dark_mode),
            title1: "Dark Mode",
            icon2: const Icon(Icons.light_mode),
            title2: "Light Mode",
            onTap1: () {
              setState(() {
                SharedPreference.setTheme(theme: "Dark");
                theme = "Dark";
                context.read<ThemeCubit>().chanheTheme(theme: theme);
              });
            },
            onTap2: () {
              setState(() {
                SharedPreference.setTheme(theme: "Light");
                theme = "Light";
                context.read<ThemeCubit>().chanheTheme(theme: theme);
              });
            },
            endWidget1: theme == "Dark"
                ? const CircleAvatar(
                    radius: 12,
                    child: Icon(
                      Icons.check,
                      size: 15,
                    ),
                  )
                : const SizedBox(),
            endWidget2: theme == "Light"
                ? const CircleAvatar(
                    radius: 12,
                    child: Icon(
                      Icons.check,
                      size: 15,
                    ),
                  )
                : const SizedBox(),
          ),
        ],
      ),
    );
  }
}
