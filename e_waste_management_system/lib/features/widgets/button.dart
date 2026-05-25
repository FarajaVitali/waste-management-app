import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final bool isOutline;
  final String btnText;
  final VoidCallback onPressed;
  const Button(
    this.isOutline,
    this.btnText, {
    required this.onPressed,
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: onPressed,
        style: isOutline
            ? ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Color(0xfffd6f22),
                side: BorderSide(color: Color(0xfffd6f22)),
              )
            : ElevatedButton.styleFrom(
                backgroundColor: Color(0xfffd6f22),
                foregroundColor: Colors.white,
              ),
        child: Text(btnText),
      ),
    );
  }
}
