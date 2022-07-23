import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static const String TOKEN = "TOKEN";
  static const String USER = "USER";

  static SharedPreferences? _prefs;
  static final Map<String, dynamic> _memoryPrefs = <String, dynamic>{};

  static Future<SharedPreferences?> load() async {
    _prefs ??= await SharedPreferences.getInstance();
    return _prefs;
  }

  static void setJson(String key, Map<String, dynamic> map) {
    final str = jsonEncode(map);
    _prefs?.setString(key, str);
  }
  static void setString(String key, String value) {
    _prefs?.setString(key, value);
    _memoryPrefs[key] = value;
  }

  static void setInt(String key, int value) {
    _prefs?.setInt(key, value);
    _memoryPrefs[key] = value;
  }

  static void setDouble(String key, double value) {
    _prefs?.setDouble(key, value);
    _memoryPrefs[key] = value;
  }

  static void setBool(String key, bool value) {
    _prefs?.setBool(key, value);
    _memoryPrefs[key] = value;
  }

  static Map<String, dynamic> getJson(String key) {
    final str = _prefs?.getString(key) ?? '{}';
    return jsonDecode(str);
  }

  static String getString(String key, {String? def}) {
    String val = '';
    if (_memoryPrefs.containsKey(key)) {
      val = _memoryPrefs[key];
    }
    if (val.isEmpty) {
      val = _prefs?.getString(key) ?? '';
    }
    if (val == null) {
      val = def!;
    }
    _memoryPrefs[key] = val;
    return val;
  }

  static int getInt(String key, {int? def}) {
    int val = 0;
    if (_memoryPrefs.containsKey(key)) {
      val = _memoryPrefs[key];
    }
    if (val == null) {
      val = _prefs!.getInt(key)!;
    }
    if (val == null) {
      val = def!;
    }
    _memoryPrefs[key] = val;
    return val;
  }

  static double getDouble(String key, {double? def}) {
    double val = 0.0;
    if (_memoryPrefs.containsKey(key)) {
      val = _memoryPrefs[key];
    }
    if (val == null) {
      val = _prefs!.getDouble(key)!;
    }
    if (val == null) {
      val = def!;
    }
    _memoryPrefs[key] = val;
    return val;
  }

  static bool getBool(String key, {bool def = false}) {
    bool val = false;
    if (_memoryPrefs.containsKey(key)) {
      val = _memoryPrefs[key];
    }
    if (val == null) {
      val = _prefs!.getBool(key)!;
    }
    if (val == null) {
      val = def;
    }
    _memoryPrefs[key] = val;
    return val;
  }

  static Future<void> clear() {
    _memoryPrefs.clear();
    return _prefs!.clear();
  }

}