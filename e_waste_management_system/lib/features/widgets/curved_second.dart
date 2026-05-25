import 'package:flutter/material.dart';

class CurvedClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    // start from bottom left
    path.lineTo(0, size.height);

    // go to bottom right
    path.lineTo(size.width, size.height);

    // go to top right
    path.lineTo(size.width, 60);

    // curve: concave wave dipping DOWN in the middle (like plant app)
    path.quadraticBezierTo(
      size.width / 2,
      0, // control point dips to 0 at center
      0,
      60, // end point top left
    );

    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
