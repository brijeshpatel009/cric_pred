// ignore_for_file: file_names

import 'package:flutter/material.dart';

import '../../../utils/utils.dart';

class ScoreInfo extends StatefulWidget {
  const ScoreInfo({Key? key, required this.info}) : super(key: key);
  final String info;

  @override
  State<ScoreInfo> createState() => _ScoreInfoState();
}

class _ScoreInfoState extends State<ScoreInfo> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Center(
          child: Padding(
            padding: EdgeInsets.only(top: height * 0.015, left: width * 0.02, right: width * 0.02),
            child: Text(
              widget.info,
              style: const TextStyle(fontSize: 18),
            ),
          ),
        ),
      ),
    );
  }
}
