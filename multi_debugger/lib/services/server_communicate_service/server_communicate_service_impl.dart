import 'dart:async';
import 'dart:convert';

import 'package:centrifuge/centrifuge.dart' as centrifuge;
import 'package:flutter/foundation.dart';
import 'package:multi_debugger/app_globals.dart';
import 'package:multi_debugger/domain/models/models.dart' show ChannelModel, ServerConnectStatus;
import 'package:multi_debugger/services/logger_service/logger_service.dart';
import 'package:rxdart/rxdart.dart';

import 'server_communicate_service.dart';

class ServerCommunicateServiceImpl extends ServerCommunicateService {
  ServerCommunicateServiceImpl({
    @required LoggerService loggerService,
    @required AppGlobals appGlobals,
  })  : assert(loggerService != null),
        assert(appGlobals != null),
        super(
          loggerService: loggerService,
          appGlobals: appGlobals,
        );

  final BehaviorSubject<ServerConnectStatus> _connectStatusSubject = BehaviorSubject<ServerConnectStatus>();
  Stream<ServerConnectStatus> get connectStatusStream => _connectStatusSubject.stream;
  ServerConnectStatus get currentConnectStatus => _connectStatusSubject.value;

  centrifuge.Client _client;
  centrifuge.Subscription _subscription;
  StreamSubscription<centrifuge.ConnectEvent> _connectSub;
  StreamSubscription<centrifuge.DisconnectEvent> _disconnectSub;
  StreamSubscription<centrifuge.PublishEvent> _publishSub;

  @override
  void init() {
    super.init();
  }

  @override
  void dispose() {
    _connectStatusSubject.close();

    super.dispose();
  }

  @override
  Future<void> connect(ChannelModel channelModel, {centrifuge.ClientConfig clientConfig}) async {
    print('>>> service connect');
    _connectStatusSubject.add(ServerConnectStatus.connecting);
    _client = centrifuge.createClient(channelModel.wsUrl);
    _subscription = _client.getSubscription(channelModel.name);

    // connect sub
    _connectSub = _client.connectStream.listen((centrifuge.ConnectEvent event) {
      print('!!!!!!!! centrifugo connected (${channelModel.name} > ${channelModel.wsUrl})');

      ChannelModel channelModelTransfer = ChannelModel((b) {
        b
          ..replace(channelModel)
          ..serverConnectStatus = ServerConnectStatus.connected;

        return b;
      });
      appGlobals.store.actions.channelActions.changeConnectStatus(channelModelTransfer);

      _connectStatusSubject.add(ServerConnectStatus.connected);
    });

    // disconnect sub
    _disconnectSub = _client.disconnectStream.listen((centrifuge.DisconnectEvent event) {
      print('!!!!!!!! centrifugo disconnected (${channelModel.name} > ${channelModel.wsUrl})');
      _connectStatusSubject.add(ServerConnectStatus.disconnected);
    });

    // publish sub
    _publishSub = _subscription.publishStream.listen((centrifuge.PublishEvent event) {
      print('!!!!!!!! centrifugo publish');
      // final Map<String, dynamic> message = json.decode(utf8.decode(event.data)) as Map<String, dynamic>;
    });

    // connect
    _subscription.subscribe();
    _client.connect();
  }

  @override
  Future<void> disconnect() async {
    print('>>> service disconnect');
    if (currentConnectStatus == ServerConnectStatus.connected) {
      _client?.disconnect();
    }

    Future<void>.delayed(const Duration(milliseconds: 200), () {
      _connectSub?.cancel();
      _disconnectSub?.cancel();
      _publishSub?.cancel();
    });

    _subscription?.unsubscribe();
    _connectStatusSubject.add(ServerConnectStatus.disconnected);
    _client = null;
  }

  @override
  Future<void> send(dynamic data) async {
    final List<int> rawData = utf8.encode(jsonEncode(data));

    await sendRawData(rawData);
  }

  @override
  Future<void> sendRawData(List<int> data) async {
    await _subscription.publish(data);
  }
}
