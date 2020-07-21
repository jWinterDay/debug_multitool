import 'dart:core';

import 'package:debug_desktop_client/services/service.dart';
import 'package:flutter/widgets.dart';

abstract class LoggerService implements Service {
  @override
  Future<void> init();

  void e(Object message);

  void d(Object message);
}

class DebugPrintLoggerServiceImpl implements LoggerService {
  DebugPrintLoggerServiceImpl();

  @override
  Future<void> init() async {}

  @override
  Future<void> dispose() async {}

  @override
  void e(Object message) {
    debugPrint(message.toString());
  }

  @override
  void d(Object message) {
    debugPrint(message.toString());
  }
}
