import 'package:centrifuge/centrifuge.dart' as centrifuge;
import 'package:flutter/foundation.dart';
import 'package:multi_debugger/app_globals.dart';
import 'package:multi_debugger/domain/models/models.dart';
import 'package:multi_debugger/services/logger_service/logger_service.dart';
import 'package:multi_debugger/services/service.dart';

abstract class ServerCommunicateService extends Service {
  ServerCommunicateService({
    @required this.loggerService,
    @required this.appGlobals,
  })  : assert(loggerService != null),
        assert(appGlobals != null);

  final LoggerService loggerService;
  final AppGlobals appGlobals;

  Future<void> connect(ChannelModel channelModel, {centrifuge.ClientConfig clientConfig});

  Future<void> disconnect();

  Future<void> send(dynamic data);

  Future<void> sendRawData(List<int> data);
}
