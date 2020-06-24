// import 'dart:async';

import 'package:debug_desktop_client/services/custom/channel_service.dart';
import 'package:debug_desktop_client/services/custom/used_url_service.dart';
import 'package:debug_desktop_client/services/db_service.dart';
import 'package:debug_desktop_client/services/logger_service.dart';
import 'package:flutter_simple_dependency_injection/injector.dart';

final Injector di = Injector.getInjector();

class AppDI {
  static Future<void> init() async {
    // logger
    final DebugPrintLoggerServiceImpl loggerService = DebugPrintLoggerServiceImpl();
    di.map<LoggerService>(
      (Injector di) {
        return loggerService;
      },
      isSingleton: true,
    );

    // db service
    di.map<DbService>(
      (Injector di) {
        return DbService(
          dbName: 'debug_desktop_client.db',
          schemaInitPath: 'assets/db/schema_init.sql',
          loggerService: loggerService,
        );
      },
      isSingleton: true,
    );

    // channel service
    di.map<ChannelService>(
      (Injector di) {
        return ChannelService(
          dbService: di.get<DbService>(),
        );
      },
      isSingleton: true,
    );

    // used url service
    di.map<UsedUrlService>(
      (Injector di) {
        return UsedUrlService(
          dbService: di.get<DbService>(),
        );
      },
      isSingleton: true,
    );

    // local storage
    // di.map<LocalStorageService>(
    //   (Injector di) {
    //     return LocalStorageServiceImpl();
    //   },
    //   isSingleton: true,
    // );

    loggerService.d('---di successfully initialized---');
  }
}
