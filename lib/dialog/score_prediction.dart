import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ScoreDialog extends StatefulWidget {
  const ScoreDialog({Key? key}) : super(key: key);

  @override
  _ScoreDialogState createState() => _ScoreDialogState();
}

class _ScoreDialogState extends State<ScoreDialog> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // Timer(Duration(seconds: 3), () {
    //   Navigator.pop(context);
    // });
  }

  @override
  Widget build(BuildContext context) {
    double height = Get.height;
    double width = Get.width;
    // var svgIconSize = (width / 100) * 20;
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: AlertDialog(
        contentPadding: EdgeInsets.all((width / 100) * 3),
        actionsPadding: EdgeInsets.only(bottom: (width / 100) * 2),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(20.0),
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Who win Match",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: (width / 100) * 4.6,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    height: height * 0.05,
                    width: height * 0.05,
                    color: Colors.orange,
                  ),
                ),
                Container(
                  height: height * 0.05,
                  width: height * 0.05,
                  color: const Color(0xff2E2445),
                ),
              ],
            ),
            SizedBox(
              height: (width / 100) * 2.0,
            ),
          ],
        ),
      ),
    );
  }
}
