import 'package:flutter/material.dart';

class FormInput extends StatelessWidget {
  final String labelText;
  final bool isPassword;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;
  final IconData? prefixIcon;

  const FormInput(
    this.labelText, {
    super.key,
    this.isPassword = false,
    this.controller,
    this.validator,
    this.keyboardType = TextInputType.text,
    this.prefixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: isPassword,
      keyboardType: keyboardType,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return '$labelText cannot be empty';
        }
        return null;
      },
      style: TextStyle(fontSize: 15, color: Colors.black87),
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(color: Colors.grey, fontSize: 14),

        // prefix icon
        prefixIcon: prefixIcon != null
            ? Icon(prefixIcon, color: Color(0xfffd6f22))
            : null,

        // suffix icon for password
        suffixIcon: isPassword
            ? Icon(Icons.visibility_off, color: Colors.grey)
            : null,

        // filled background
        filled: true,
        fillColor: Colors.grey.shade50,

        // borders
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
          borderSide: BorderSide(color: Color(0xfffd6f22), width: 1.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
          borderSide: BorderSide(color: Colors.black, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
          borderSide: BorderSide(color: Colors.red, width: 1.5),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.red, width: 2),
        ),

        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      ),
    );
  }
}
