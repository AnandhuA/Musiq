import 'package:flutter/material.dart';
import 'package:musiq/core/colors.dart';

class CustomTextFeild extends StatelessWidget {
  final String hintText;
  final Function(String)? onChanged;
  final Function(String)? onSubmitted;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final Widget icon;
  const CustomTextFeild({
    super.key,
    required this.hintText,
    this.onChanged,
    this.onSubmitted,
    this.controller,
    this.focusNode,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      focusNode: focusNode,
      controller: controller,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      decoration: InputDecoration(
        prefixIcon: icon,
        hintText: hintText,
        filled: true,
        fillColor: Theme.of(context).brightness == Brightness.dark
            ? AppColors.textfeildDarkBG
            : AppColors.textfeildLightBG,
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(18),
        ),
      ),
    );
  }
}
