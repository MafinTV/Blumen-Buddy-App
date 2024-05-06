import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefManager {
  static final SharedPrefManager _instance = SharedPrefManager._internal();

  factory SharedPrefManager() => _instance;

  SharedPrefManager._internal();

  SharedPreferences? _prefs;

  Future<void> initialize() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // Methods to get/set data using the _prefs instance
  // (implement methods for different data types like String, int, bool, etc.)
  String getString(String key) => _prefs?.getString(key) ?? '';

  Future<void> setString(String key, String value) async {
    await _prefs?.setString(key, value);
  }

  // Add similar methods for other data types

  Future<void> remove(String key) async {
    await _prefs?.remove(key);
  }
}
