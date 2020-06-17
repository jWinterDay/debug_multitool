// import 'dart:async';

import 'package:debug_desktop_client/app_di.dart';
import 'package:debug_desktop_client/services/local_storage_service.dart';
import 'package:debug_desktop_client/services/logger_service.dart';

class AppLocalStorage {
  static Future<void> init() async {
    LoggerService loggerService = di.get<LoggerService>();

    LocalStorageService localStorageService = di.get<LocalStorageService>();
    await localStorageService.init();

    loggerService.d('---local storage successfully initialized---');
  }
}
