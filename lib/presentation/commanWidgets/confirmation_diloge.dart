import 'package:flutter/material.dart';

confirmationDiloge(
    {required BuildContext context,
    required String title,
    required Function confirmBtn,
    required String content}) {
  final theme = Theme.of(context);
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(
          title,
          style: theme.textTheme.titleLarge,
        ),
        content: Text(
          content,
          style: theme.textTheme.titleMedium,
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Text(
              "No",
              style: theme.textTheme.titleLarge,
            ),
          ),
          IconButton(
            onPressed: () => confirmBtn(),
            icon: Text(
              "Yes",
              style: theme.textTheme.titleLarge,
            ),
          )
        ],
      );
    },
  );
}
