import 'package:flutter/material.dart';

import '../dialog/internet_check.dart';

void printLog(String message) {
  print('FlutterPrint: $message');
}

class Utils {
  static void hideKeyboard(BuildContext context) {
    var currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
      FocusManager.instance.primaryFocus!.unfocus();
    }
  }

  static void showNoInternetDialog(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return const NoInternetDialog();
      },
    );
  }

  static String matchDataString(String data) {
    String matchData = data;
    matchData = matchData.replaceAll('PLZ RATE US 5 STARS', '');
    matchData = matchData.replaceAll('*****', '');
    matchData = matchData.replaceAll('Share This App and Rate us on Playstore', '');
    return matchData;
  }
}
