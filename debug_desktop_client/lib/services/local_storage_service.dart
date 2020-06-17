import 'dart:core';
import 'package:debug_desktop_client/services/service.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class LocalStorageService implements Service {
  @override
  Future<void> init();

  // get
  String getString(String key);

  bool getBool(String key);

  int getInt(String key);

  List<String> getStringList(String key);

  // set
  Future<bool> setString(String key, String val);

  Future<bool> setBool(String key, bool val);

  Future<bool> setInt(String key, int val);

  Future<bool> setStringList(String key, List<String> val);
}

class LocalStorageServiceImpl extends LocalStorageService {
  LocalStorageServiceImpl();

  SharedPreferences preferences;

  @override
  Future<void> init() async {
    preferences = await SharedPreferences.getInstance();
  }

  // get
  @override
  String getString(String key) {
    return preferences.getString(key);
  }

  @override
  bool getBool(String key) {
    return preferences.getBool(key);
  }

  @override
  int getInt(String key) {
    return preferences.getInt(key);
  }

  @override
  List<String> getStringList(String key) {
    return preferences.getStringList(key);
  }

  // set
  @override
  Future<bool> setString(String key, String val) async {
    return await preferences.setString(key, val);
  }

  @override
  Future<bool> setBool(String key, bool val) async {
    return await preferences.setBool(key, val);
  }

  @override
  Future<bool> setInt(String key, int val) async {
    return await preferences.setInt(key, val);
  }

  @override
  Future<bool> setStringList(String key, List<String> val) async {
    return await preferences.setStringList(key, val);
  }
}
