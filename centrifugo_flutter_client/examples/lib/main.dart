import 'dart:async';

import 'package:centrifugo_flutter_client/centrifugo_flutter_client.dart';
import 'package:flutter/material.dart';

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
      debugPrint('unexpected error: $error, tacktrace: $stackTrace');
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
        body: Column(
          children: <Widget>[
            const CentrifugoConnectWidget(),
            RaisedButton(
              onPressed: () {
                try {
                  DataSender.sendData(
                    action: 'example_action',
                    payload: <String, dynamic>{'payloadKey1': 1, 'payloadKey2': 2},
                    state: <String, dynamic>{
                      'stateKey1': 'test123',
                      'stateKey2': <dynamic>[1, 2, 3, 4, 5]
                    },
                  );
                } catch (exc) {
                  debugPrint('exc = $exc');
                }
              },
              child: const Text('send data'),
            ),
          ],
        ),
      ),
    );
  }
}
