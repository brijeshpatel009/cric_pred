// ignore_for_file: avoid_print

import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void printLog(String message) {
  print('FlutterPrint: $message');
}

double height = Get.height;
double width = Get.width;
double logoHeight = height * 0.2;
double minSize = min(height, width);
double maxSize = max(height, width);

class Utils {
  static void hideKeyboard(BuildContext context) {
    var currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
      FocusManager.instance.primaryFocus!.unfocus();
    }
  }

  static String matchDataString(String data) {
    String matchData = data;
    matchData = matchData.replaceAll('PLZ RATE US 5 STARS', '');
    matchData = matchData.replaceAll('*****', '');
    matchData = matchData.replaceAll('Share This App and Rate us on Playstore', '');
    return matchData;
  }

  static Widget tabsWidget(String string) {
    return Text(
      string,
      style: TextStyle(fontSize: minSize * 0.05, fontWeight: FontWeight.w400),
    );
  }
}
