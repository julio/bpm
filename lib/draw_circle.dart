import 'package:flutter/material.dart';

class DrawCircle extends CustomPainter {
  late Paint _paint;

  DrawCircle() {
    _paint = Paint()
      ..color       = Color.fromRGBO(92, 184, 92, 0.2)
      ..strokeWidth = 10.0
      ..style       = PaintingStyle.fill;
  }

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawCircle(Offset(0.0, 0.0), 120.0, _paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
