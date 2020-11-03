import 'dart:async';
import 'dart:convert';

import 'package:built_value/json_object.dart';
import 'package:centrifuge/centrifuge.dart' as centrifuge;
import 'package:flutter/foundation.dart';
import 'package:multi_debugger/domain/base/pair.dart';
import 'package:multi_debugger/domain/enums/server_event_type.dart';
import 'package:multi_debugger/domain/models/models.dart';
import 'package:multi_debugger/services/logger_service/logger_service.dart';
import 'package:multi_debugger/services/server_communicate_service/server_error.dart';

import 'server_communicate_service.dart';
import 'system_service_action.dart';

class ServerCommunicateServiceImpl extends ServerCommunicateService {
  ServerCommunicateServiceImpl({
    @required LoggerService loggerService,
  })  : assert(loggerService != null),
        super(
          loggerService: loggerService,
        );

  centrifuge.Client _client;
  centrifuge.Subscription _subscription;
  StreamSubscription<centrifuge.ConnectEvent> _connectSub;
  StreamSubscription<centrifuge.DisconnectEvent> _disconnectSub;
  StreamSubscription<centrifuge.PublishEvent> _publishSub;

  bool _connected = false;

  @override
  Future<void> connect(ChannelModel channelModel, String channelName, {centrifuge.ClientConfig clientConfig}) async {
    loggerService.d('service connect for composite channel name: $channelName');

    _client = centrifuge.createClient(channelModel.wsUrl);
    _subscription = _client.getSubscription(channelName);

    // connect sub
    _connectSub = _client.connectStream.listen((centrifuge.ConnectEvent connectEvent) {
      loggerService.d('service connect to channel id: ${channelModel.channelId}: $connectEvent');

      _connected = true;
      super.connectSubject.add(channelModel);
    });

    // disconnect sub
    _disconnectSub = _client.disconnectStream.listen((centrifuge.DisconnectEvent disconnectEvent) {
      loggerService.d('service disconnect for channel id: ${channelModel.channelId}');

      _connected = false;
      _connectSub?.cancel();
      _disconnectSub?.cancel();
      _publishSub?.cancel();

      final bool closed = disconnectSubject?.isClosed ?? true;
      if (!closed) {
        super.disconnectSubject.add(channelModel);
      }
    });

    // publish sub
    // add {"action": "createNewChannel", "payload": {"name": "test_1", "wsUrl": "ws://172.16.55.141:8001/connection/websocket?format=protobuf"}, "state": true}
    // delete {"action": "deleteChannel", "payload": {"name": "test_1"}}
    _publishSub = _subscription.publishStream.listen((centrifuge.PublishEvent publishEvent) {
      final dynamic message = json.decode(utf8.decode(publishEvent.data));

      if (message is! Map) {
        const ServerError serverError = ServerError(
          message: 'REMOTE. Format error. Message type is not Map',
          serverEventType: ServerEventType.formatError,
        );

        super.errorSubject.add(Pair(channelModel, serverError));
        return;
      }

      final Map<String, dynamic> messageMap = message as Map<String, dynamic>;

      String action = (messageMap['action'] ?? 'Unknown action').toString();
      JsonObject payload = JsonObject(messageMap['payload'] ?? 'Unknown payload');
      JsonObject state = JsonObject(messageMap['state'] ?? 'Unknown state');

      if (payload.isMap) {
        // complex payload it may be a control command
        // check if action is control command
        Map<dynamic, dynamic> payloadMap = payload.asMap;
        String channelName = payloadMap['name']?.toString() ?? '';
        String channelId = payloadMap['channelId']?.toString() ?? '';

        switch (action) {
          // add channel
          case SystemServiceAction.createNewChannel:
            String wsUrl = payloadMap['wsUrl']?.toString() ?? '';

            // validate
            if (channelName == '' || wsUrl == '') {
              const ServerError serverError = ServerError(
                message: 'REMOTE. Unknown name or ws url when adding',
                serverEventType: ServerEventType.errorControlCommand,
              );

              super.errorSubject.add(Pair(channelModel, serverError));
              return;
            }

            ServerEvent serverEvent = ServerEvent((b) {
              return b
                ..action = action
                ..payload = payload
                ..state = state
                ..serverEventType = ServerEventType.controlCommand;
            });
            super.publishSubject.add(Pair(channelModel, serverEvent));

            return;

          // delete channel by name or id
          case SystemServiceAction.deleteChannel:
            // validate
            if (channelName == '' && channelId == '') {
              const ServerError serverError = ServerError(
                message: 'REMOTE. Unknown name and id when deleting',
                serverEventType: ServerEventType.errorControlCommand,
              );

              super.errorSubject.add(Pair(channelModel, serverError));
              return;
            }

            ServerEvent serverEvent = ServerEvent((b) {
              return b
                ..action = action
                ..payload = payload
                ..state = state
                ..serverEventType = ServerEventType.controlCommand;
            });
            super.publishSubject.add(Pair(channelModel, serverEvent));
            return;

          // not control command
          default:
        }
      } else if (SystemServiceAction.isControlCommand(action)) {
        const ServerError serverError = ServerError(
          message: 'REMOTE. Payload must be a Map',
          serverEventType: ServerEventType.errorControlCommand,
        );

        super.errorSubject.add(Pair(channelModel, serverError));

        return;
      }

      // simple payload
      ServerEvent serverEvent = ServerEvent((b) {
        return b
          ..action = action
          ..payload = payload
          ..state = state
          ..serverEventType = ServerEventType.action;
      });

      super.publishSubject.add(Pair(channelModel, serverEvent));
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
