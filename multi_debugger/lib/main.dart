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

      final AppGlobals appGlobals = di.get<AppGlobals>();
      await appGlobals.init();

      di.get<AppGlobals>().store.actions.appConfigActions.fetchComputerName();
      di.get<AppGlobals>().store.actions.appConfigActions.fetchSavedUrls();
      di.get<AppGlobals>().store.actions.appConfigActions.fetchSavedChannels();

      runApp(const App());
    },
    (error, stackTrace) async {
      di.get<LoggerService>().e('Unexpected error: $error', error.runtimeType, stackTrace);
    },
  );
}
