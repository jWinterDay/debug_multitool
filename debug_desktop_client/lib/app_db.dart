// import 'dart:async';

import 'package:debug_desktop_client/app_di.dart';
import 'package:debug_desktop_client/services/db_service.dart';
import 'package:debug_desktop_client/services/logger_service.dart';

class AppDb {
  static Future<void> init() async {
    final DebugPrintLoggerServiceImpl loggerService = DebugPrintLoggerServiceImpl();
    final DbService dbService = di.get<DbService>();

    await dbService.init();

    loggerService.d('---local storage successfully initialized---');
  }
}
