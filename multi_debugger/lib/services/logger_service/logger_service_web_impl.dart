import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

import 'logger_service.dart';

class LoggerServiceWebImpl extends LoggerService {
  @override
  void setLoggerLevel(Level level) {}

  @override
  void init() {
    super.init();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void d(dynamic message, [dynamic error, StackTrace stackTrace]) {
    if (!kDebugMode) return;

    // ignore: avoid_print
    print(message);
  }

  @override
  void e(dynamic message, [dynamic error, StackTrace stackTrace]) {
    if (!kDebugMode) return;

    // ignore: avoid_print
    print(message);
  }

  @override
  void i(dynamic message, [dynamic error, StackTrace stackTrace]) {
    if (!kDebugMode) return;

    // ignore: avoid_print
    print(message);
  }
}
