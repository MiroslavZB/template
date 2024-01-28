import 'package:flutter/material.dart';

class TextFieldModel {
  final String hint;
  final bool obscureText;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final Widget? suffixIcon;

  const TextFieldModel({
    required this.hint,
    this.obscureText = false,
    required this.controller,
    this.validator,
    this.suffixIcon,
  });
}
