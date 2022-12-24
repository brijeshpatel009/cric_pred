// ignore_for_file: file_names, must_be_immutable

import 'package:flutter/material.dart';

class LoginPaint extends StatefulWidget {
  double width;
  double height;

  LoginPaint({required this.width, required this.height, Key? key}) : super(key: key);

  @override
  State<LoginPaint> createState() => _LoginPaintState();
}

class _LoginPaintState extends State<LoginPaint> {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: MyPaint(),
      size: Size(widget.width, widget.height),

    );
  }
}

class MyPaint extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = const Color(0xaaFA9536);
    paint.style = PaintingStyle.fill;

    var path = Path();
    path.moveTo(size.width * 0.4, 0);
    path.lineTo(size.width * 0.668, size.height * 0.16);
    path.quadraticBezierTo(size.width * 0.69, size.height * 0.17, size.width * 0.71, size.height * 0.16);
    path.lineTo(size.width, 0);
    canvas.drawPath(path, paint);

    var path1 = Path();
    path1.moveTo(size.width, size.height * 0.07);
    path1.lineTo(size.width * 0.15, size.height * 0.55);
    path1.quadraticBezierTo(size.width * 0.1, size.height * 0.575, size.width * 0.15, size.height * 0.60);
    path1.lineTo(size.width * 0.5, size.height * 0.76);
    path1.quadraticBezierTo(size.width * 0.55, size.height * 0.78, size.width * 0.6, size.height * 0.76);
    path1.lineTo(size.width, size.height * 0.54);
    canvas.drawPath(path1, paint);

    var path2 = Path();
    path2.moveTo(size.width * 0.25, size.height);
    path2.lineTo(size.width * 0.65, size.height * 0.78);
    path2.quadraticBezierTo(size.width * 0.72, size.height * 0.75, size.width * 0.81, size.height * 0.8);
    path2.lineTo(size.width, size.height * 0.90);
    path2.lineTo(size.width, size.height);
    canvas.drawPath(path2, paint);


    var path3 = Path();
    path3.moveTo(size.width * 0.24, 0);
    path3.lineTo(size.width*0.88, size.height*0.4);
    path3.quadraticBezierTo(size.width*0.95, size.height*0.45, size.width*0.85, size.height*0.5);
    path3.lineTo(0, size.height*0.97);
    path3.lineTo(0, 0);
    Paint paint1 = Paint()..color =  Colors.white;
    paint1.style = PaintingStyle.fill;
    canvas.drawPath(path3, paint1);



  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
