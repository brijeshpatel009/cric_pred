// ignore_for_file: file_names, must_be_immutable

import 'package:flutter/material.dart';

// class WaveShapeBorder extends ShapeBorder {
//   @override EdgeInsetsGeometry get dimensions => EdgeInsets.zero;
//   @override Path? getInnerPath(Rect rect, {required TextDirection textDirection}) =>  null;
//
//   @override
//   Path getOuterPath(Rect rect, {required TextDirection textDirection}) {
//     var ctrl1 = FractionalOffset(0.35, 0.75).withinRect(rect);
//     var end1  = FractionalOffset(0.65, 0.85).withinRect(rect);
//     var ctrl2 = FractionalOffset(0.85, 0.90).withinRect(rect);
//     var end2  = FractionalOffset(1.0,  0.75).withinRect(rect);
//     return Path()
//       ..moveTo(rect.topLeft.dx, rect.topLeft.dy)
//       ..lineTo(rect.bottomLeft.dx, rect.bottomLeft.dy)
//       ..quadraticBezierTo(ctrl1.dx, ctrl1.dy, end1.dx, end1.dy)
//       ..quadraticBezierTo(ctrl2.dx, ctrl2.dy, end2.dx, end2.dy)
//       ..lineTo(rect.topRight.dx, rect.topRight.dy)
//       ..close();
//   }
//
//   @override void paint(Canvas canvas, Rect rect, {required TextDirection textDirection}) {}
//   @override ShapeBorder scale(double t) => this;
// }



class WaveBorder extends ShapeBorder{
  late double height;
  late double width;
  WaveBorder({required this.height,required this.width});
  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.zero;

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    throw UnimplementedError();
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    // var ctrl1 = const FractionalOffset(0.35, 0.75).withinRect(rect);
    // var end1  = const FractionalOffset(0.65, 0.85).withinRect(rect);
    // var ctrl2 = const FractionalOffset(0.85, 0.90).withinRect(rect);
    // var end2  = const FractionalOffset(1.0,  0.75).withinRect(rect);
    return Path()
      ..moveTo(width * 0.24, 0)
      ..lineTo(width*0.88, height*0.4)
      ..quadraticBezierTo(width*0.95, height*0.45, width*0.85, height*0.5)
      ..lineTo(0, height*0.97)
      ..lineTo(0, 0)
      ..close();
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {}

  @override
  ShapeBorder scale(double t) {
    throw UnimplementedError();
  }
}




