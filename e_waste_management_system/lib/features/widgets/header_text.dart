import 'package:flutter/material.dart';

class HeaderText extends StatelessWidget {
  final String text;
  final double fontSize;
  const HeaderText(this.text, {this.fontSize = 36, super.key});
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.w600),
    );
  }
}
