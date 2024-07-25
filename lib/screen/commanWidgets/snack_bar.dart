import 'package:flutter/material.dart';


customSnackbar({
  required BuildContext context,
  required String message,
  required Color color,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        message,
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
      backgroundColor: color,
      duration: const Duration(
        milliseconds: 1200,
      ),
    ),
  );
}
