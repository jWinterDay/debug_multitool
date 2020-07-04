import 'package:shared_preferences/shared_preferences.dart';

const String kUrlKey = 'centrifugoUrl';
const String kChannelKey = 'centrifugoChannel';

String formatEnumToStr(String enumString) {
  return enumString.split('.')[1];
}

/// local storage
Future<String> getStringFromLocalStorage(String key) async {
  try {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(key) ?? '';
  } catch (exc) {
    print('SharedPreferences exc: $exc');
  }

  return '';
}

Future<void> setStringToLocalStorage(String key, String val) async {
  try {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString(key, val);
  } catch (exc) {
    print('SharedPreferences exc: $exc');
  }
}
