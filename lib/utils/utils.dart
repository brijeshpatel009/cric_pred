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
}
