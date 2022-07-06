import '../../../../../core/app_theme.dart';
import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final bool isSecure;
  final String label;
  // final String? Function(String?) validate;
  const TextFieldWidget({
    Key? key,
    required this.isSecure,
    required this.controller,
    required this.label,
    // required this.validate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      // onFieldSubmitted: submit,
      style: const TextStyle(color: primaryColor),
      controller: controller,
      obscureText: isSecure,
      validator: (val) {
        if (val!.isEmpty) {
          return "$label must not be empty";
        }
      },
      // cursorColor: Colors.deepOrange,
      decoration: InputDecoration(
        filled: true,
        focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: primaryColor),
            borderRadius: BorderRadius.circular(20)),
        // iconColor: Theme.of(context).iconTheme.color,
        labelStyle: const TextStyle(color: primaryColor),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(color: primaryColor)),
        border: OutlineInputBorder(
            borderSide: const BorderSide(color: primaryColor),
            borderRadius: BorderRadius.circular(20)),
        label: Text(label),
        // prefixIcon: icon,
        // suffixIcon: suffixIcon,
      ),
    );
  }
}
