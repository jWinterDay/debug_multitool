import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

// todo go to DI
class LoggerRepository {
  final bool _enableLog = true;

  void e(Object message) {
    if (!_enableLog || kReleaseMode) {
      return;
    }

    debugPrint(message.toString());
  }

  void d(Object message) {
    if (!_enableLog || kReleaseMode) {
      return;
    }

    debugPrint(message.toString());
  }
}
