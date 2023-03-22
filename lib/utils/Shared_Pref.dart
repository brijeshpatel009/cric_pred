// ignore_for_file: file_names

import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesDatas {
  static late SharedPreferences prefs;

  static const String selectedMatchName = "selectedMatch";
  static const String adCounter = "adCounter";
  static const String adBool = "adCounter";

  static Future<void> initialPreference() async {
    prefs = await SharedPreferences.getInstance();
  }

  ///Set StringList
  static Future<void> setStringList(String key, List<String> value) async {
    await prefs.setStringList(key, value);
  }

  static List<String> getStringList(String key) {
    return prefs.getStringList(key) ?? [];
  }

  ///Set int
  static Future<void> setInt(String key, int value) async {
    await prefs.setInt(key, value);
  }

  static int getInt(String key) {
    return prefs.getInt(key) ?? 0;
  }

  ///Set Bool
  static Future<void> setBool(String key, bool value) async {
    await prefs.setBool(key, value);
  }

  static bool getBool(String key) {
    return prefs.getBool(key) ?? true;
  }
}
