import 'dart:async';
import 'dart:convert';

import 'package:centrifuge/centrifuge.dart' as centrifuge;
import 'package:flutter/foundation.dart';
import 'package:multi_debugger/app_globals.dart';
import 'package:multi_debugger/domain/base/pair.dart';
import 'package:multi_debugger/domain/models/models.dart';
import 'package:multi_debugger/services/logger_service/logger_service.dart';

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
    super.dispose();
  }

  @override
  Future<void> connect(ChannelModel channelModel, {centrifuge.ClientConfig clientConfig}) async {
    loggerService.d('service connect for channel id: ${channelModel.channelId}');
    _client = centrifuge.createClient(channelModel.wsUrl);
    _subscription = _client.getSubscription(channelModel.name);

    // connect sub
    _connectSub = _client.connectStream.listen((centrifuge.ConnectEvent event) {
      // channel connect status
      ChannelModel channelModelTransfer = ChannelModel((b) {
        b
          ..replace(channelModel)
          ..serverConnectStatus = ServerConnectStatus.connected;

        return b;
      });
      appGlobals.store.actions.channelActions.changeConnectStatus(channelModelTransfer);

      // server event -> connect
      ServerEvent serverEvent = ServerEvent((b) {
        b
          ..action = 'connect'
          ..serverEventType = ServerEventType.connect;

        return b;
      });

      Pair<String, ServerEvent> event = Pair(channelModel.channelId, serverEvent);
      appGlobals.store.actions.serverEventActions.addEvent(event);
    });

    // disconnect sub
    _disconnectSub = _client.disconnectStream.listen((centrifuge.DisconnectEvent event) {
      loggerService.d('service disconnect for channel id: ${channelModel.channelId}');

      // server event -> disconnect
      ServerEvent serverEvent = ServerEvent((b) {
        b
          ..action = 'disconnect'
          ..serverEventType = ServerEventType.disconnect;

        return b;
      });

      Pair<String, ServerEvent> event = Pair(channelModel.channelId, serverEvent);
      appGlobals.store.actions.serverEventActions.addEvent(event);
    });

    // publish sub
    _publishSub = _subscription.publishStream.listen((centrifuge.PublishEvent event) {
      // final Map<String, dynamic> message = json.decode(utf8.decode(event.data)) as Map<String, dynamic>;
    });

    // connect
    _subscription.subscribe();
    _client.connect();
  }

  @override
  Future<void> disconnect() async {
    _client?.disconnect();

    Future<void>.delayed(const Duration(milliseconds: 200), () {
      _connectSub?.cancel();
      _disconnectSub?.cancel();
      _publishSub?.cancel();
    });

    _subscription?.unsubscribe();
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
