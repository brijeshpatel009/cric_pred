// ignore_for_file: file_names
import 'package:flutter/material.dart';

class MyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint1 = Paint()
      ..color = const Color(0xff63aa65)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10;
    //draw arc
    canvas.drawArc(const Offset(-40, -40) & const Size(75, 75),
        1.6, //radians
        3.1, //radians
        false,
        paint1);
  }

  @override
  bool shouldRepaint(MyPainter oldDelegate) => false;
}