import 'package:flutter/material.dart';

customSnackbar({
  required BuildContext context,
  required String message,
  required Color bgColor,
  required Color textColor,
  Duration duration = const Duration(
    milliseconds: 1200,
  ),
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        message,
        style: TextStyle(color: textColor),
      ),
      backgroundColor: bgColor,
      duration: duration
    ),
  );
}
