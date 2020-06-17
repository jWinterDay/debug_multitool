import 'dart:async';
import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;
import 'package:debug_desktop_client/app_di.dart';
import 'package:debug_desktop_client/services/logger_service.dart';

AppTranslations appTranslations = AppTranslations();

class AppTranslations {
  static final LoggerService _loggerService = di.get<LoggerService>();

  static Map<String, dynamic> _localizedValues;

  static Future<void> init({String langCode = 'ru'}) async {
    final String txt = await rootBundle.loadString('assets/locale/$langCode.json');
    _localizedValues = json.decode(txt) as Map<String, dynamic>;

    _loggerService.d('---app translations successfully initialized---');
  }

  String text(String key) {
    assert(_localizedValues[key] != null, 'AppTranslations: $key not found');

    if (_localizedValues[key] == null) {
      return 'TEXT NOT FOUND';
    }

    return _localizedValues[key] as String;
  }

  /// Example
  ///
  /// ```json
  /// // locale.json
  /// {
  ///   "sample": "This string contains interpolation: {someArg}"
  /// }
  /// ```
  ///
  /// ```dart
  /// // some.dart
  /// appTranslations.fmt('sample', arguments: { 'someArg': 123 })
  /// ```
  String fmt(String key, {Map<String, dynamic> arguments}) {
    final String value = _localizedValues[key] as String;
    assert(value != null);

    return value.replaceAllMapped(
      RegExp(r'{(\w*)}'),
      (Match m) {
        if (arguments[m[1]] == null) {
          throw Exception('AppTranslations: Argument with name "${m[1]}" not found');
        }

        return arguments[m[1]].toString();
      },
    );
  }

  List<String> array(String key) {
    assert(_localizedValues[key] != null, 'AppTranslations: $key not found');

    final List<String> output = _localizedValues[key].cast<String>() as List<String>;

    return output;
  }
}
