import 'package:shared_preferences/shared_preferences.dart';

class LocalData {
  static SharedPreferences? _prefs;
  static SharedPreferences? get prefs => _prefs;

  static const String firstKey = 'first';

  static Future<void> initSharedPreferences() async {
    _prefs = await SharedPreferences.getInstance();
  }
}
