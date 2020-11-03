import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:multi_debugger/app_globals.dart';
import 'package:multi_debugger/domain/epics/local_epic.dart';
import 'package:multi_debugger/domain/epics/remote_epic.dart';
import 'package:multi_debugger/domain/epics/server_connect_epic.dart';
import 'package:multi_debugger/services/local_station_service/local_station_service.dart';
import 'package:multi_debugger/services/local_station_service/local_station_service_impl.dart';
import 'package:multi_debugger/services/local_storage_service/local_storage_service.dart';
import 'package:multi_debugger/services/local_storage_service/local_storage_service_impl.dart';
import 'package:multi_debugger/services/logger_service/logger_service.dart';
import 'package:multi_debugger/services/logger_service/logger_service_impl.dart';
import 'package:multi_debugger/services/logger_service/logger_service_web_impl.dart';
import 'package:multi_debugger/services/remove_storage_service/remote_storage_service.dart';
import 'package:multi_debugger/services/remove_storage_service/remote_storage_service_impl.dart';
import 'package:multi_debugger/services/server_communicate_service/server_communicate_service.dart';
import 'package:multi_debugger/services/server_communicate_service/server_communicate_service_impl.dart';
import 'package:flutter_simple_dependency_injection/injector.dart';

final Injector di = Injector.getInjector();

class AppDI {
  static Future<void> init() async {
    final LoggerService loggerService = kIsWeb ? LoggerServiceWebImpl() : LoggerServiceImpl();
    loggerService.init();

    LocalStorageService localStorage = LocalStorageServiceImpl(loggerService: loggerService)..init();
    await localStorage.initStorage();

    di
      // logger
      ..map<LoggerService>(
        (Injector di) => loggerService,
        isSingleton: true,
      )

      // app globals
      ..map<AppGlobals>(
        (Injector di) => AppGlobals(loggerService: loggerService),
        isSingleton: true,
      )

      // local storage
      ..map<LocalStorageService>(
        (Injector injector) => localStorage,
        isSingleton: true,
      )

      // remote storage
      ..map<RemoteStorageService>(
        (Injector injector) => RemoteStorageServiceImpl()..init(),
        isSingleton: true,
      )

      // local station service
      ..map<LocalStationService>(
        (Injector injector) => LocalStationServiceImpl(loggerService: loggerService)..init(),
        isSingleton: false,
      )

      // server communicate
      ..map<ServerCommunicateService>(
        (Injector injector) => ServerCommunicateServiceImpl(
          loggerService: loggerService,
        )..init(),
        isSingleton: false, // !
      )

      // remote epic
      ..map<RemoteEpic>(
        (Injector injector) => RemoteEpic(),
        isSingleton: true,
      )

      // server communicate epic
      ..map<ServerConnectEpic>(
        (Injector injector) => ServerConnectEpic(
          loggerService: loggerService,
        ),
        isSingleton: true,
      )

      // local station epic
      ..map<LocalEpic>(
        (Injector injector) => LocalEpic(
          localStationService: di.get<LocalStationService>(),
          localStorageService: di.get<LocalStorageService>(),
          loggerService: loggerService,
        ),
        isSingleton: true,
      );

    loggerService.i('di successfully initialized');
  }
}
