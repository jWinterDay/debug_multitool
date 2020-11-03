import 'package:centrifuge/centrifuge.dart' as centrifuge;
import 'package:flutter/foundation.dart';
import 'package:multi_debugger/domain/base/pair.dart';
import 'package:multi_debugger/domain/models/models.dart';
import 'package:multi_debugger/services/logger_service/logger_service.dart';
import 'package:multi_debugger/domain/base/base_service.dart';
import 'package:multi_debugger/services/server_communicate_service/server_error.dart';
import 'package:rxdart/subjects.dart';

abstract class ServerCommunicateService extends BaseService {
  ServerCommunicateService({
    @required this.loggerService,
  }) : assert(loggerService != null);

  final LoggerService loggerService;

  BehaviorSubject<ChannelModel> connectSubject = BehaviorSubject<ChannelModel>();
  BehaviorSubject<ChannelModel> disconnectSubject = BehaviorSubject<ChannelModel>();

  /// channelModel -> message
  BehaviorSubject<Pair<ChannelModel, ServerError>> errorSubject = BehaviorSubject<Pair<ChannelModel, ServerError>>();

  /// channelModel -> data from server
  BehaviorSubject<Pair<ChannelModel, ServerEvent>> publishSubject = BehaviorSubject<Pair<ChannelModel, ServerEvent>>();

  Future<void> connect(ChannelModel channelModel, String channelName, {centrifuge.ClientConfig clientConfig});

  Future<void> disconnect();

  Future<void> send(dynamic data);

  Future<void> sendRawData(List<int> data);

  @override
  void dispose() {
    connectSubject.close();
    disconnectSubject.close();
    errorSubject.close();
    publishSubject.close();

    super.dispose();
  }
}
