import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget commonContainer({required Widget child, double? size, double? radius}) {
  double height = Get.height;
  double width = Get.width;
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: width * 0.06, vertical: height * 0.015),
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
