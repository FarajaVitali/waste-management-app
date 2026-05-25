import 'package:flutter/material.dart';

class NormalText extends StatelessWidget {
  final String text;
  final double textSize;
  const NormalText(this.text, {this.textSize = 16, super.key});
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(fontSize: textSize),
      textAlign: TextAlign.center,
    );
  }
}
