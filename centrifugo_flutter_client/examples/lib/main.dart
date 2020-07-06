import 'dart:async';

import 'package:centrifugo_flutter_client/centrifugo_flutter_client.dart';
import 'package:centrifugo_flutter_client/src/repositories/logger_repository.dart';
import 'package:flutter/material.dart';

LoggerRepository _loggerRepository = LoggerRepository();

Future<void> _run() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

void main() {
  FlutterError.onError = (FlutterErrorDetails details) async {
    Zone.current.handleUncaughtError(details.exception, details.stack);
  };

  runZonedGuarded<void>(
    () => _run(),
    (Object error, StackTrace stackTrace) {
      _loggerRepository.e('unexpected error: $error, tacktrace: $stackTrace');
    },
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'centrifugo flutter client',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('centrifugo flutter client example'),
        ),
        body: const CentrifugoConnectWidget(),
      ),
    );
  }
}
