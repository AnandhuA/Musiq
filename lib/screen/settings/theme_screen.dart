import 'package:flutter/material.dart';
import 'package:musiq/core/sized.dart';
import 'package:musiq/screen/settings/widgets/list_tile_widget.dart';

class ThemeScreen extends StatefulWidget {
  const ThemeScreen({super.key});

  @override
  State<ThemeScreen> createState() => _ThemeScreenState();
}

class _ThemeScreenState extends State<ThemeScreen> {
  String theme = "System";
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
                theme = "System";
              });
            },
            endWidget: theme == "System"
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
                theme = "Dark";
              });
            },
            onTap2: () {
              setState(() {
                theme = "Light";
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
