import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../utils/utils.dart';

class ConnectionConfig {
  static final ConnectionConfig _connectionConfig = ConnectionConfig._internal();

  factory ConnectionConfig() {
    return _connectionConfig;
  }

  ConnectionConfig._internal();

  final Connectivity _connectivity = Connectivity();

  Future<void> initConnectivity() async {
    late ConnectivityResult result;

    try {
      result = await _connectivity.checkConnectivity();

      if (result == ConnectivityResult.none) {
        Utils.showNoInternetDialog(Get.context!);
      }
    } on PlatformException catch (e) {
      printLog('Couldn\'t check connectivity status Error: $e');
      return;
    }
  }
}
