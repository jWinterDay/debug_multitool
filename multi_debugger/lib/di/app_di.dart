import 'dart:async';

import 'package:flutter_simple_dependency_injection/injector.dart';
import 'package:multi_debugger/services/local_storage_service/local_storage_service.dart';
import 'package:multi_debugger/services/local_storage_service/local_storage_service_impl.dart';
import 'package:multi_debugger/services/logger_service/logger_service.dart';
import 'package:multi_debugger/services/logger_service/logger_service_impl.dart';
import 'package:multi_debugger/services/remove_storage_service/remote_storage_service.dart';
import 'package:multi_debugger/services/remove_storage_service/remote_storage_service_impl.dart';

final Injector di = Injector.getInjector();

class AppDI {
  static Future<void> init() async {
    // logger
    final LoggerService loggerService = LoggerServiceImpl()..init();
    di
      ..map<LoggerService>(
        (Injector di) => loggerService,
        isSingleton: true,
      )

      // local storage
      ..map<LocalStorageService>(
        (Injector injector) => LocalStorageServiceImpl()..init(),
        isSingleton: true,
      )

      // remote storage
      ..map<RemoteStorageService>(
        (Injector injector) => RemoteStorageServiceImpl()..init(),
        isSingleton: true,
      );

    loggerService.d('---di successfully initialized---');
  }
}
