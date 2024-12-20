import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:musiq/core/colors.dart';
import 'package:musiq/core/global_variables.dart';
import 'package:musiq/core/sized.dart';
import 'package:musiq/bloc/ThemeCubit/theme_cubit.dart';
import 'package:musiq/presentation/screens/settingsScreen/widgets/list_tile_widget.dart';
import 'package:musiq/data/shared_preference.dart';

class ThemeScreen extends StatefulWidget {
  const ThemeScreen({super.key});

  @override
  State<ThemeScreen> createState() => _ThemeScreenState();
}

class _ThemeScreenState extends State<ThemeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Change Theme"),
        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios_new_sharp)),
        actions: [
          Lottie.asset("assets/animations/Animation1.json"),
        ],
      ),
      body: Column(
        children: [
          ListTileWidget(
            icon: const Icon(Icons.system_update),
            title: "System",
            onTap: () {
              setState(() {
                SharedPreference.setTheme(theme: "System");
                AppGlobals().theme = "System";
                context
                    .read<ThemeCubit>()
                    .chanheTheme(theme: AppGlobals().theme);
              });
            },
            endWidget:
                AppGlobals().theme == "System" || AppGlobals().theme == null
                    ? const CircleAvatar(
                        radius: 12,
                        child: Icon(
                          Icons.check,
                          size: 15,
                        ),
                      )
                    : const SizedBox(),
          ),
          AppSpacing.height20,
          MultiListTileWidget(
            icon1: const Icon(Icons.dark_mode),
            title1: "Dark Mode",
            icon2: const Icon(Icons.light_mode),
            title2: "Light Mode",
            onTap1: () {
              setState(() {
                SharedPreference.setTheme(theme: "Dark");
                AppGlobals().theme = "Dark";
                context
                    .read<ThemeCubit>()
                    .chanheTheme(theme: AppGlobals().theme);
              });
            },
            onTap2: () {
              setState(() {
                SharedPreference.setTheme(theme: "Light");
                AppGlobals().theme = "Light";
                context
                    .read<ThemeCubit>()
                    .chanheTheme(theme: AppGlobals().theme);
              });
            },
            endWidget1: AppGlobals().theme == "Dark"
                ? const CircleAvatar(
                    radius: 12,
                    child: Icon(
                      Icons.check,
                      size: 15,
                    ),
                  )
                : const SizedBox(),
            endWidget2: AppGlobals().theme == "Light"
                ? const CircleAvatar(
                    radius: 12,
                    child: Icon(
                      Icons.check,
                      size: 15,
                    ),
                  )
                : const SizedBox(),
          ),
          AppSpacing.height30,
          const Text("Chose your color"),
          AppSpacing.height20,
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5,
                childAspectRatio: 1.5,
                mainAxisSpacing: 12.0,
                crossAxisSpacing: 8.0,
              ),
              itemCount: AppColors.colorList.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    SharedPreference.setColorIndex(
                      colorIndex: index,
                    );
                    setState(() {
                      AppGlobals().colorIndex = index;
                    });
                    context
                        .read<ThemeCubit>()
                        .chanheTheme(theme: AppGlobals().theme);
                  },
                  child: CircleAvatar(
                    backgroundColor: AppColors.colorList[index],
                    child: AppGlobals().colorIndex == index
                        ? const Icon(
                            Icons.check,
                            color: AppColors.black,
                            size: 35,
                          )
                        : const SizedBox(),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
