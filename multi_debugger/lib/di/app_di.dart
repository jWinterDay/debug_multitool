import 'dart:async';

import 'package:flutter_simple_dependency_injection/injector.dart';
import 'package:multi_debugger/domain/epics/remote_epic.dart';
import 'package:multi_debugger/services/local_storage_service/local_storage_service.dart';
import 'package:multi_debugger/services/local_storage_service/local_storage_service_impl.dart';
import 'package:multi_debugger/services/logger_service/logger_service.dart';
import 'package:multi_debugger/services/logger_service/logger_service_impl.dart';
import 'package:multi_debugger/services/remove_storage_service/remote_storage_service.dart';
import 'package:multi_debugger/services/remove_storage_service/remote_storage_service_impl.dart';
import 'package:multi_debugger/services/server_communicate_service/server_communicate_service.dart';
import 'package:multi_debugger/services/server_communicate_service/server_communicate_service_impl.dart';

final Injector di = Injector.getInjector();

class AppDI {
  static Future<void> init() async {
    final LoggerService loggerService = LoggerServiceImpl()..init();

    di
      // logger
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
      )

      // server communicate
      ..map<ServerCommunicateService>(
        (Injector injector) => ServerCommunicateServiceImpl(loggerService: loggerService)..init(),
        isSingleton: false, // !
      )

      // remote epic
      ..map<RemoteEpic>(
        (Injector injector) => RemoteEpic(),
        isSingleton: true,
      );

    loggerService.d('---di successfully initialized---');
  }
}
