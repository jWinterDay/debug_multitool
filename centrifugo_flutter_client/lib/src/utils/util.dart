import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String kUrlKey = 'centrifugoUrl';
const String kChannelKey = 'centrifugoChannel';

String formatEnumToStr(String enumString) {
  return enumString.split('.')[1];
}

/// local storage
Future<String> getStringFromLocalStorage(String key) async {
  try {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(key) ?? '';
  } catch (exc) {
    debugPrint('SharedPreferences exc: $exc');
  }

  return '';
}

Future<void> setStringToLocalStorage(String key, String val) async {
  try {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString(key, val);
  } catch (exc) {
    debugPrint('SharedPreferences exc: $exc');
  }
}

String urlFieldValidator(String val) {
  if (val.isEmpty) {
    return 'Enter url';
  }
  return null;
}

String channelFieldValidator(String val) {
  if (val.isEmpty) {
    return 'Enter channel name';
  }
  return null;
}
