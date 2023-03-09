import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class NoInternetDialog extends StatefulWidget {
  const NoInternetDialog({Key? key}) : super(key: key);

  @override
  _NoInternetDialogState createState() => _NoInternetDialogState();
}

class _NoInternetDialogState extends State<NoInternetDialog> {
  RxBool isConnecting = false.obs;
  static const MethodChannel _channel = MethodChannel('toast_message');

  static Future<bool> showToast(String message) async {
    bool res = await _channel.invokeMethod('showToast', {'msg': message});
    return res;
  }

  static void checkInternet(Function callback) async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        callback.call();
      }
    } on SocketException catch (_) {
      showToast("noInternetConnection");
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = Get.width;
    var svgIconSize = (width / 100) * 20;
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
            // Image.asset(
            //   'assets/images/no_internet_connection.png',
            //   height: svgIconSize,
            //   width: svgIconSize,
            // ),
            SizedBox(
              height: (width / 100) * 1.5,
            ),
            Text(
              'No Internet Connection',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: (width / 100) * 4.6,
              ),
            ),
            SizedBox(
              height: (width / 100) * 2.0,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: (width / 100) * 5),
              child: Text(
                'Check your Internet connection and try again',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: (width / 100) * 3.8,
                ),
              ),
            ),
          ],
        ),
        actions: [
          Align(
            child: Obx(
              () => ElevatedButton(
                style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: (width / 100) * 12, vertical: 12),
                    backgroundColor: const MaterialColor(0xFF0067E2, <int, Color>{
                      50: Color(0xFFE0EDFC),
                      100: Color(0xFFB3D1F6),
                      200: Color(0xFF80B3F1),
                      300: Color(0xFF4D95EB),
                      400: Color(0xFF267EE6),
                      500: Color(0xFF0067E2),
                      600: Color(0xFF005FDF),
                      700: Color(0xFF0054DA),
                      800: Color(0xFF004AD6),
                      900: Color(0xFF0039CF),
                    })),
                onPressed: () async {
                  checkInternet(() async {
                    try {
                      isConnecting.value = true;
                      Get.back();
                    } catch (e) {
                      showToast("Something was wrong. Please restart this app");
                    } finally {
                      isConnecting.value = false;
                    }
                  });
                },
                child: Text(isConnecting.value ? 'Connecting..' : 'Refresh'),
              ),
            ),
          )
        ],
      ),
    );
  }
}
