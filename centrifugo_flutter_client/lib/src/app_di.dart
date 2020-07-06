// import 'dart:async';

import 'package:flutter_simple_dependency_injection/injector.dart';

import 'repositories/local_storage_repository.dart';
import 'repositories/logger_repository.dart';

final Injector di = Injector.getInjector();

class AppDI {
  static Future<void> init() async {
    // logger
    final LoggerRepository loggerRepository = LoggerRepository();
    di.map<LoggerRepository>(
      (Injector di) {
        return LoggerRepository();
      },
      isSingleton: true,
    );

    // local storage
    di.map<LocalStorageRepository>(
      (Injector di) {
        return LocalStorageRepository(loggerRepository);
      },
      isSingleton: true,
    );

    loggerRepository.d('---di successfully initialized---');
  }
}
