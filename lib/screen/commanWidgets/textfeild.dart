import 'package:flutter/material.dart';

class CustomTextFeild extends StatelessWidget {
  final String hintText;
  final Function(String)? onChanged;
  final Function(String)? onSubmitted;
  final TextEditingController? controller;
    final FocusNode? focusNode;
  const CustomTextFeild({
    super.key,
    required this.hintText,
    this.onChanged,
    this.onSubmitted,
    this.controller,
        this.focusNode,

  });

  @override
  Widget build(BuildContext context) {
    return TextField(
       focusNode: focusNode,
      controller: controller,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.search),
        
        hintText: hintText,
        filled: true,
        fillColor: Theme.of(context).brightness == Brightness.dark
            ? const Color.fromARGB(255, 32, 32, 32)
            : const Color.fromARGB(255, 196, 196, 196),
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(18),
        ),
      ),
    );
  }
}
