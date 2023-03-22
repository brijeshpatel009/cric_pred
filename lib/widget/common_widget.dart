import 'package:flutter/material.dart';

import '../utils/utils.dart';

Widget commonContainer({required Widget child, double? size, double? radius, double? paddingHor}) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: paddingHor ?? width * 0.06, vertical: height * 0.015),
    child: Container(
      height: size,
      decoration: BoxDecoration(
        color: const Color(0xffF1F5FE),
        borderRadius: BorderRadius.all(Radius.circular(radius ?? height * 0.03)),
        boxShadow: const [
          BoxShadow(
            color: Colors.black45,
            blurRadius: 10,
            spreadRadius: -1.8,
            offset: Offset(0.0, 0.0),
          )
        ],
      ),
      child: child,
    ),
  );
}
