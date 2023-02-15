import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesDatas {
  static late SharedPreferences prefs;

  static const String selectedMatchName = "selectedMatch";

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
}
