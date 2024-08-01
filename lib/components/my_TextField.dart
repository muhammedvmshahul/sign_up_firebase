import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final bool obscureText;
  final String? labelText;
  final TextStyle? labelStyle;
  final TextStyle? hintStyle;
  final String? Function(String?)? validator;

  const MyTextField(
      {super.key,
      required this.controller,
      this.hintText,
      required this.obscureText,
      this.labelText,
      required this.labelStyle,
      this.hintStyle,
      this.validator});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        labelText: labelText,
        labelStyle: labelStyle,
        hintStyle: hintStyle,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
        ),
      ),
      obscureText: obscureText,
    );
  }
}
