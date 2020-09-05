import 'dart:async';

import 'package:flutter/material.dart';
import 'package:multi_debugger/app/app.dart';
import 'package:multi_debugger/app_globals.dart';
import 'package:multi_debugger/di/app_di.dart';
import 'package:multi_debugger/services/logger_service/logger_service.dart';

Future<void> main() async {
  runZonedGuarded<void>(
    () async {
      WidgetsFlutterBinding.ensureInitialized();

      await AppDI.init();
      await di.get<AppGlobals>().init();

      runApp(const App());
    },
    (error, stackTrace) async {
      di.get<LoggerService>().e('Unexpected error: $error', error.runtimeType, stackTrace);
    },
  );
}
