import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final bool required;
  final bool obscureText;
  final int? maxLines;
  final int? maxLength;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  const CustomTextFormField(
      {this.controller,
      super.key,
      this.hintText,
      this.required = true,
      this.validator,
      this.obscureText = false,
      this.maxLines = 1,
      this.keyboardType,
      this.maxLength,
      this.onChanged});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      maxLines: maxLines,
      maxLength: maxLength,
      keyboardType: keyboardType,
      onChanged: onChanged,
      validator: validator == null && required
          ? (value) {
              if (value == null || value.isEmpty) {
                return "Required";
              }
              return null;
            }
          : validator,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: hintText,
      ),
    );
  }
}
