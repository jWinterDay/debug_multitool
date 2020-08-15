import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

import 'logger_service.dart';

class LoggerServiceImpl extends LoggerService {
  Logger _logger;

  @override
  void init() {
    super.init();

    _logger = Logger(printer: PrettyPrinter(printTime: true));
  }

  @override
  void dispose() {
    _logger.close();

    super.dispose();
  }

  @override
  void d(dynamic message, [dynamic error, StackTrace stackTrace]) {
    if (!kDebugMode) return;

    _logger.d(message, error, stackTrace);
  }

  @override
  void e(dynamic message, [dynamic error, StackTrace stackTrace]) {
    if (!kDebugMode) return;

    _logger.e(message, error, stackTrace);
  }

  @override
  void i(dynamic message, [dynamic error, StackTrace stackTrace]) {
    if (!kDebugMode) return;

    _logger.i(message, error, stackTrace);
  }
}
