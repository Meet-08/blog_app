import 'package:flutter/material.dart';

class AuthField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final bool isObscureText;

  const AuthField({
    super.key,
    required this.hintText,
    required this.controller,
    this.isObscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: isObscureText,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(27),
        hintText: hintText,
      ),
      controller: controller,
      validator: (value) {
        if (value != null && value.isEmpty) {
          return "$hintText is empty";
        }
        return null;
      },
    );
  }
}
