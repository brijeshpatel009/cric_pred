import 'package:flutter/material.dart';

class DividerWidget extends StatelessWidget {
  const DividerWidget({Key? key, this.color, this.thickness}) : super(key: key);
  final Color? color;
  final double? thickness;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: thickness ?? 1,
      margin: EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: color ?? Colors.black,
      ),
    );
  }
}

class VerticalDividerWidget extends StatelessWidget {
  const VerticalDividerWidget({Key? key, this.color, this.thickness}) : super(key: key);
  final Color? color;
  final double? thickness;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: thickness ?? 1.0,
      margin: const EdgeInsets.symmetric(horizontal: 10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: color ?? Colors.black,
      ),
    );
  }
}
