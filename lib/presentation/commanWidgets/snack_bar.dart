import 'package:flutter/material.dart';

customSnackbar(
    {required BuildContext context,
    required String message,
    required Color bgColor,
    required Color textColor,}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        message,
        style: TextStyle(color: textColor),
      ),
      backgroundColor: bgColor,
      duration: const Duration(
        milliseconds: 1200,
      ),
    ),
  );
}
