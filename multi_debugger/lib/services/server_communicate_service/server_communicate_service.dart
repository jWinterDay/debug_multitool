import 'package:centrifuge/centrifuge.dart' as centrifuge;
import 'package:flutter/foundation.dart';
import 'package:multi_debugger/services/logger_service/logger_service.dart';
import 'package:multi_debugger/services/service.dart';

abstract class ServerCommunicateService extends Service {
  ServerCommunicateService({
    @required this.loggerService,
  }) : assert(loggerService != null);

  final LoggerService loggerService;

  Future<void> connect(String url, String channelName, {centrifuge.ClientConfig clientConfig});

  Future<void> disconnect();

  Future<void> send(dynamic data);

  Future<void> sendRawData(List<int> data);
}
