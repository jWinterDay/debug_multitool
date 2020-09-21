import 'dart:async';
import 'dart:convert';

import 'package:built_value/json_object.dart';
import 'package:centrifuge/centrifuge.dart' as centrifuge;
import 'package:flutter/foundation.dart';
import 'package:multi_debugger/app_globals.dart';
import 'package:multi_debugger/domain/base/pair.dart';
import 'package:multi_debugger/domain/enums/server_event_type.dart';
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

  bool _connected = false;

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

    String computerName = appGlobals.store.state.appConfigState.computerName?.trim() ?? '';
    String compositeChannelName = computerName + '_' + channelModel.name;

    _client = centrifuge.createClient(channelModel.wsUrl);
    _subscription = _client.getSubscription(compositeChannelName);

    // connect sub
    _connectSub = _client.connectStream.listen((centrifuge.ConnectEvent event) {
      _connected = true;

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

      _connected = false;

      // server event -> disconnect
      ServerEvent serverEvent = ServerEvent((b) {
        b
          ..action = 'disconnect'
          ..serverEventType = ServerEventType.disconnect;

        return b;
      });

      Pair<String, ServerEvent> event = Pair(channelModel.channelId, serverEvent);
      appGlobals.store.actions.serverEventActions.addEvent(event);

      _connectSub?.cancel();
      _disconnectSub?.cancel();
      _publishSub?.cancel();
    });

    // publish sub
    _publishSub = _subscription.publishStream.listen((centrifuge.PublishEvent publishEvent) {
      final dynamic message = json.decode(utf8.decode(publishEvent.data));

      if (message is! Map) {
        ServerEvent serverEvent = ServerEvent((b) {
          b
            ..action = 'Format error. Message type is not Map'
            ..serverEventType = ServerEventType.formatError;

          return b;
        });

        Pair<String, ServerEvent> event = Pair(channelModel.channelId, serverEvent);
        appGlobals.store.actions.serverEventActions.addEvent(event);
        return;
      }

      final Map<String, dynamic> messageMap = message as Map<String, dynamic>;

      String action = (messageMap['action'] ?? 'Unknown action').toString();
      JsonObject payload = JsonObject(messageMap['payload'] ?? 'Unknown payload');
      JsonObject state = JsonObject(messageMap['state'] ?? 'Unknown state');

      ServerEvent serverEvent = ServerEvent((b) {
        b
          ..action = action
          ..payload = payload
          ..state = state
          ..serverEventType = ServerEventType.action;

        return b;
      });

      Pair<String, ServerEvent> event = Pair(channelModel.channelId, serverEvent);
      appGlobals.store.actions.serverEventActions.addEvent(event);
    });

    // connect
    _subscription.subscribe();
    _client.connect();
  }

  @override
  Future<void> disconnect() async {
    if (_connected) {
      _client.disconnect();
    }

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
