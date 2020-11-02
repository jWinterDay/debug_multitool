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
import 'package:multi_debugger/services/server_communicate_service/system_service_action.dart';
import 'package:multi_debugger/tools/common_tools.dart';

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
    String computerName = appGlobals.store.state.appConfigState.computerName?.trim() ?? '';
    String compositeChannelName = computerName + '_' + channelModel.name;
    loggerService.d('service connect for composite channel name: $compositeChannelName');

    _client = centrifuge.createClient(channelModel.wsUrl);
    _subscription = _client.getSubscription(compositeChannelName);

    // connect sub
    _connectSub = _client.connectStream.listen((centrifuge.ConnectEvent connectEent) {
      _connected = true;

      // channel connect status
      Pair<ChannelModel, ServerConnectStatus> pair = Pair(channelModel, ServerConnectStatus.connected);
      appGlobals.store.actions.channelActions.changeConnectStatus(pair);

      // server event -> connect
      ServerEvent serverEvent = ServerEvent((b) {
        b
          ..action = 'connect'
          // test
          // ..state = JsonObject({
          //   'state': {
          //     'userstate': {
          //       'logged': false,
          //       'name': 'anonym',
          //       'k': {'kVal': true}
          //     },
          //     'livestate': {'count': 0, 'video': 0, 'another': '666'},
          //     'linestate': [1, 2, 3]
          //   },
          //   'sub': false,
          //   'one': 'one1'
          // })
          ..serverEventType = ServerEventType.connect;

        return b;
      });

      Pair<String, ServerEvent> event = Pair(channelModel.channelId, serverEvent);
      appGlobals.store.actions.serverEventActions.addEvent(event);
    });

    // disconnect sub
    _disconnectSub = _client.disconnectStream.listen((centrifuge.DisconnectEvent disconnectEvent) {
      loggerService.d('service disconnect for channel id: ${channelModel.channelId}');

      _connected = false;

      // channel connect status
      // ChannelModel nextChannelModel = ChannelModel((b) {
      //   b
      //     ..replace(channelModel)
      //     ..isCurrent = true;

      //   return b;
      // });
      // Pair<ChannelModel, ServerConnectStatus> channelPair = Pair(channelModel, ServerConnectStatus.disconnected);
      // appGlobals.store.actions.channelActions.changeConnectStatus(channelPair);

      // server event -> disconnect
      ServerEvent serverEvent = ServerEvent((b) {
        b
          ..action = 'disconnect'
          // test
          // ..state = JsonObject({
          //   'state': {
          //     'userstate': {
          //       'logged': false,
          //       'name': 'Vasya',
          //       'k': {'kVal': false}
          //     },
          //     'livestate': {'count': 1, 'video': 5},
          //     'linestate': [1, 2, 3]
          //   },
          //   'sub': true,
          //   'else': 'else1'
          // })
          ..serverEventType = ServerEventType.disconnect;

        return b;
      });

      Pair<String, ServerEvent> eventPair = Pair(channelModel.channelId, serverEvent);
      appGlobals.store.actions.serverEventActions.addEvent(eventPair);

      // server is shutdown
      // if (event.shouldReconnect) {
      //   return;
      // }

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

      Pair<String, ServerEvent> pair = Pair(channelModel.channelId, serverEvent);

      _eventPairHandler(pair);
    });

    // connect
    _subscription.subscribe();
    _client.connect();
  }

  /// event handler
  /// format input data for adding new channel
  /// {
  ///   "action": "createNewChannel",
  ///   "payload": {
  ///     "name": "test_1",
  ///     "autoConnect": true,
  ///     "wsUrl": "ws://172.16.55.141:8001/connection/websocket?format=protobuf"
  ///   }
  /// }
  ///
  /// format input data for deleting channel
  /// {
  ///   "action": "deleteChannel",
  ///   "payload": {
  ///     "name": "test_1"
  ///   }
  /// }
  ///
  ///
  /// {"action": "deleteChannel", "payload": {"name": "test_1"}}
  /// {"action": "createNewChannel", "payload": {"name": "test_1", "autoConnect": true,"wsUrl": "ws://172.16.55.141:8001/connection/websocket?format=protobuf"}}
  void _eventPairHandler(Pair<String, ServerEvent> pair) {
    String channelId = pair.first;
    ServerEvent serverEvent = pair.second;
    JsonObject payload = serverEvent.payload;

    if (!payload.isMap) {
      ServerEvent errorServerEvent = ServerEvent((b) {
        b
          ..action = 'Format error. Payload type is not Map'
          ..serverEventType = ServerEventType.formatError;

        return b;
      });

      appGlobals.store.actions.serverEventActions.addEvent(Pair(channelId, errorServerEvent));
      return;
    }

    switch (serverEvent.action) {
      // add
      case SystemServiceAction.createNewChannel:
        Map<dynamic, dynamic> payloadMap = payload.asMap;

        String channelName = payloadMap['name']?.toString();
        String channelShortName = payloadMap['shortName'] == null ? channelName : payloadMap['shortName'].toString();
        bool autoConnect = payloadMap['autoConnect'] is bool ? (payloadMap['autoConnect'] as bool) : false;
        String wsUrl = payloadMap['wsUrl']?.toString();

        // validate
        final String validateNameMess = checkChannelName(channelName);
        final String validateShortNameMess = checkChannelShortName(channelShortName);
        final String validateWsUrl = checkWsUrl(wsUrl);

        final bool correctName = validateNameMess == null;
        final bool correctShortName = validateShortNameMess == null;
        final bool correctWsUrl = validateWsUrl == null;

        if (!correctName || !correctShortName || !correctWsUrl) {
          ServerEvent errorServerEvent = ServerEvent((b) {
            b
              ..action = (validateNameMess ?? validateShortNameMess ?? validateWsUrl)
              ..serverEventType = ServerEventType.formatError;

            return b;
          });

          appGlobals.store.actions.serverEventActions.addEvent(Pair(channelId, errorServerEvent));
          break;
        }

        Iterable<String> channelNames = appGlobals.store.state.channelState.channels.values.map((ChannelModel cm) {
          return cm.name;
        });

        final bool nameContains = channelNames.contains(channelName);
        if (nameContains) {
          ServerEvent errorServerEvent = ServerEvent((b) {
            b
              ..action = 'you have already this channel name'
              ..payload = JsonObject('channel $channelName has already added to channel list')
              ..serverEventType = ServerEventType.formatError;

            return b;
          });

          appGlobals.store.actions.serverEventActions.addEvent(Pair(channelId, errorServerEvent));
          break;
        }

        // add channel
        ChannelModel channelModel = ChannelModel((b) {
          return b
            ..name = channelName
            ..shortName = channelShortName
            ..serverConnectStatus = ServerConnectStatus.disconnected
            ..isCurrent = false
            ..wsUrl = wsUrl
            ..autoConnect = autoConnect;
        });
        appGlobals.store.actions.channelActions.addChannel(channelModel);

        // info to current channel
        ServerEvent errorServerEvent = ServerEvent((b) {
          b
            ..action = 'added new channel'
            ..payload = JsonObject({
              'name': channelName,
              'short name': channelShortName,
              'ws url': wsUrl,
              'autoconnect': autoConnect,
            })
            ..serverEventType = ServerEventType.formatError;

          return b;
        });

        appGlobals.store.actions.serverEventActions.addEvent(Pair(channelId, errorServerEvent));

        break;

      // delete
      case SystemServiceAction.deleteChannel:
        Map<dynamic, dynamic> payloadMap = payload.asMap;
        String channelName = payloadMap['name']?.toString() ?? '';
        String channelId = payloadMap['channelId']?.toString() ?? '';

        // validate
        if (channelId == null && channelName == null) {
          ServerEvent errorServerEvent = ServerEvent((b) {
            b
              ..action = 'Remote deleting. Unknown channel ID and Name'
              ..serverEventType = ServerEventType.formatError;

            return b;
          });

          appGlobals.store.actions.serverEventActions.addEvent(Pair(channelId, errorServerEvent));
          break;
        }

        // try to delete channel by id
        if (channelId != '') {
          appGlobals.store.actions.channelActions.removeChannelById(channelId);
          break;
        }

        // try to delete channel by name
        if (channelName != '') {
          appGlobals.store.actions.channelActions.removeChannelByName(channelName);
          break;
        }

        break;
      default:
        appGlobals.store.actions.serverEventActions.addEvent(pair);
    }
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
