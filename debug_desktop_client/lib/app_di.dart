// import 'dart:async';

import 'package:debug_desktop_client/services/custom/app_settings_service.dart';
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
      (Injector di) => loggerService,
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
      (Injector di) => ChannelService(dbService: di.get<DbService>()),
      isSingleton: true,
    );

    // used url service
    di.map<UsedUrlService>(
      (Injector di) => UsedUrlService(dbService: di.get<DbService>()),
      isSingleton: true,
    );

    // app settings service
    di.map<AppSettingsService>(
      (Injector di) => AppSettingsService(dbService: di.get<DbService>()),
      isSingleton: true,
    );

    loggerService.d('---di successfully initialized---');
  }
}
