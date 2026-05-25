import 'package:flutter/material.dart';

class IconBtn extends StatelessWidget {
  final VoidCallback onPressed;
  const IconBtn({required this.onPressed, super.key});
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(Icons.arrow_back, color: Colors.white),
    );
  }
}
