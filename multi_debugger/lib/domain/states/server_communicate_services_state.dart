import 'dart:async';

import 'package:built_value/json_object.dart';
import 'package:multi_debugger/app_globals.dart';
import 'package:multi_debugger/di/app_di.dart';
import 'package:multi_debugger/domain/base/pair.dart';
import 'package:multi_debugger/domain/enums/server_event_type.dart';
import 'package:multi_debugger/domain/models/models.dart';
import 'package:multi_debugger/services/server_communicate_service/server_communicate_service.dart';
import 'package:multi_debugger/services/server_communicate_service/server_error.dart';
import 'package:multi_debugger/services/server_communicate_service/system_service_action.dart';
import 'package:multi_debugger/tools/common_tools.dart' as common_tools;

class ServerCommunicateServicesState {
  final Map<String, ServerCommunicateService> _services = {};

  // subscriptions
  final Map<String, StreamSubscription<ChannelModel>> _connnectSubscriptions = {};
  final Map<String, StreamSubscription<ChannelModel>> _disconnnectSubscriptions = {};
  final Map<String, StreamSubscription<Pair<ChannelModel, ServerError>>> _errorSubscriptions = {};
  // final Map<String, StreamSubscription<Pair<ChannelModel, Map<String, dynamic>>>> _publishSubscriptions = {};
  final Map<String, StreamSubscription<Pair<ChannelModel, ServerEvent>>> _publishSubscriptions = {};

  final AppGlobals appGlobals = di.get<AppGlobals>();

  ServerCommunicateService getService(String channelId) {
    return _services[channelId];
  }

  /// add single service to channel
  void addService(String channelId, ServerCommunicateService service) {
    _services.putIfAbsent(channelId, () => service);

    _connnectSubscriptions.putIfAbsent(channelId, () => service.connectSubject.listen(_connectHandler));
    _disconnnectSubscriptions.putIfAbsent(channelId, () => service.disconnectSubject.listen(_disconnectHandler));
    _errorSubscriptions.putIfAbsent(channelId, () => service.errorSubject.listen(_errorHandler));
    _publishSubscriptions.putIfAbsent(channelId, () => service.publishSubject.listen(_publishHandler));
  }

  /// add multiple services to channels
  void addAllServices(Map<String, ServerCommunicateService> services) {
    _services.addAll(services);

    // connect
    services.forEach((String channelId, ServerCommunicateService service) {
      _connnectSubscriptions.putIfAbsent(channelId, () => service.connectSubject.listen(_connectHandler));
    });

    // disconnect
    services.forEach((String channelId, ServerCommunicateService service) {
      _disconnnectSubscriptions.putIfAbsent(channelId, () => service.disconnectSubject.listen(_disconnectHandler));
    });

    // error
    services.forEach((String channelId, ServerCommunicateService service) {
      _errorSubscriptions.putIfAbsent(channelId, () => service.errorSubject.listen(_errorHandler));
    });

    // publish
    services.forEach((String channelId, ServerCommunicateService service) {
      _publishSubscriptions.putIfAbsent(channelId, () => service.publishSubject.listen(_publishHandler));
    });
  }

  void removeService(String channelId) {
    _services.remove(channelId);

    _connnectSubscriptions[channelId]?.cancel();
    _disconnnectSubscriptions[channelId]?.cancel();
    _errorSubscriptions[channelId]?.cancel();
    _publishSubscriptions[channelId]?.cancel();
  }

  /// connect listener handler
  void _connectHandler(ChannelModel channelModel) {
    appGlobals.store.actions.channelActions.changeConnectStatus(Pair(channelModel, ServerConnectStatus.connected));

    ServerEvent serverEvent = ServerEvent((b) {
      return b
        ..action = 'connect'
        ..serverEventType = ServerEventType.connect;
    });

    Pair<String, ServerEvent> event = Pair(channelModel.channelId, serverEvent);
    appGlobals.store.actions.serverEventActions.addEvent(event);
  }

  /// disconnect listener handler
  void _disconnectHandler(ChannelModel channelModel) {
    ServerEvent disconnectEvent = ServerEvent((b) {
      return b
        ..action = 'disconnect'
        ..serverEventType = ServerEventType.disconnect;
    });

    appGlobals.store.actions.serverEventActions.addEvent(Pair(channelModel.channelId, disconnectEvent));
  }

  /// error listener handler
  void _errorHandler(Pair<ChannelModel, ServerError> errorPair) {
    final ChannelModel channelModel = errorPair.first;
    final ServerError serverError = errorPair.second;

    ServerEvent errorEvent = ServerEvent((b) {
      return b
        ..action = serverError.message
        ..payload = JsonObject(serverError.message)
        ..serverEventType = serverError.serverEventType;
    });

    appGlobals.store.actions.serverEventActions.addEvent(Pair(channelModel.channelId, errorEvent));
  }

  /// error listener handler
  void _publishHandler(Pair<ChannelModel, ServerEvent> errorPair) {
    final ChannelModel channelModel = errorPair.first;
    final ServerEvent serverEvent = errorPair.second;

    // String action = (messageMap['action'] ?? 'Unknown action').toString();
    // JsonObject payload = JsonObject(messageMap['payload'] ?? 'Unknown payload');
    // JsonObject state = JsonObject(messageMap['state'] ?? 'Unknown state');

    // ServerEvent serverEvent = ServerEvent((b) {
    //   return b
    //     ..action = action
    //     ..payload = payload
    //     ..state = state
    //     ..serverEventType = ServerEventType.action;
    // });

    Pair<String, ServerEvent> pair = Pair(channelModel.channelId, serverEvent);

    _eventPairHandler(pair);
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

    // control command
    if (serverEvent.serverEventType == ServerEventType.controlCommand) {
      JsonObject payload = serverEvent.payload;
      Map<dynamic, dynamic> payloadMap = payload.asMap;
      String payloadChannelName = payloadMap['name']?.toString() ?? '';
      String payloadChannelId = payloadMap['channelId']?.toString() ?? '';

      switch (serverEvent.action) {
        // Iterable<String> channelNames = appGlobals.store.state.channelState.channels.values.map((ChannelModel cm) {
        //     return cm.name;
        //   });

        //   if (channelNames.contains(payloadChannelName)) {}

        // delete channel
        case SystemServiceAction.deleteChannel:
          if (payloadChannelId != '') {
            appGlobals.store.actions.channelActions.removeChannelById(payloadChannelId);
            // info to current channel
            ServerEvent errorServerEvent = ServerEvent((b) {
              b
                ..action = 'REMOTE. Removed channel by id'
                ..payload = JsonObject('removed channel by id: $payloadChannelId')
                ..serverEventType = ServerEventType.controlCommand;

              return b;
            });
            appGlobals.store.actions.serverEventActions.addEvent(Pair(channelId, errorServerEvent));

            break;
          }

          if (payloadChannelName != '') {
            appGlobals.store.actions.channelActions.removeChannelByName(payloadChannelName);
            // info to current channel
            ServerEvent errorServerEvent = ServerEvent((b) {
              b
                ..action = 'REMOTE. Removed channel'
                ..payload = JsonObject('removed channel by name: $payloadChannelName')
                ..serverEventType = ServerEventType.controlCommand;

              return b;
            });
            appGlobals.store.actions.serverEventActions.addEvent(Pair(channelId, errorServerEvent));

            break;
          }

          break;

        // add channel
        case SystemServiceAction.createNewChannel:
          String payloadChannelShortName =
              payloadMap['shortName'] == null ? payloadChannelName : payloadMap['shortName'].toString();
          bool autoConnect = payloadMap['autoConnect'] is bool ? (payloadMap['autoConnect'] as bool) : false;
          String wsUrl = payloadMap['wsUrl']?.toString();

          // validate
          final String validateNameMess = common_tools.checkChannelName(payloadChannelName);
          final String validateShortNameMess = common_tools.checkChannelShortName(payloadChannelShortName);
          final String validateWsUrl = common_tools.checkWsUrl(wsUrl);
          final bool correctName = validateNameMess == null;
          final bool correctShortName = validateShortNameMess == null;
          final bool correctWsUrl = validateWsUrl == null;
          if (!correctName || !correctShortName || !correctWsUrl) {
            ServerEvent errorServerEvent = ServerEvent((b) {
              return b
                ..action = (validateNameMess ?? validateShortNameMess ?? validateWsUrl)
                ..payload = JsonObject({
                  'name': payloadChannelName,
                  'shortName': payloadChannelName,
                  'autoConnect': autoConnect,
                  'wsUrl': wsUrl
                })
                ..serverEventType = ServerEventType.errorControlCommand;
            });

            appGlobals.store.actions.serverEventActions.addEvent(Pair(channelId, errorServerEvent));
            break;
          }

          Iterable<String> channelNames = appGlobals.store.state.channelState.channels.values.map((ChannelModel cm) {
            return cm.name;
          });

          if (channelNames.contains(payloadChannelName)) {
            ServerEvent errorServerEvent = ServerEvent((b) {
              return b
                ..action = 'REMOTE. Error adding new channel'
                ..payload = JsonObject('channel $payloadChannelName has already added to channel list')
                ..serverEventType = ServerEventType.errorControlCommand;
            });

            appGlobals.store.actions.serverEventActions.addEvent(Pair(channelId, errorServerEvent));
            break;
          }

          // add channel
          ChannelModel channelModel = ChannelModel((b) {
            return b
              ..name = payloadChannelName
              ..shortName = payloadChannelShortName
              ..serverConnectStatus = ServerConnectStatus.disconnected
              ..isCurrent = false
              ..wsUrl = wsUrl
              ..autoConnect = autoConnect;
          });
          appGlobals.store.actions.channelActions.addChannel(channelModel);

          // info to current channel
          ServerEvent errorServerEvent = ServerEvent((b) {
            b
              ..action = 'REMOTE. Added new channel'
              ..payload = JsonObject({
                'name': payloadChannelName,
                'short name': payloadChannelShortName,
                'ws url': wsUrl,
                'autoconnect': autoConnect,
              })
              ..serverEventType = ServerEventType.controlCommand;

            return b;
          });
          appGlobals.store.actions.serverEventActions.addEvent(Pair(channelId, errorServerEvent));

          break;

        default:
      }

      return;
    }

    JsonObject payload = serverEvent.payload;

    appGlobals.store.actions.serverEventActions.addEvent(pair); //Pair(channelId, errorServerEvent));
    return;

    if (!payload.isMap) {
      // ServerEvent errorServerEvent = ServerEvent((b) {
      //   b
      //     ..action = 'Format error. Payload type is not Map'
      //     ..serverEventType = ServerEventType.formatError;

      //   return b;
      // });

      appGlobals.store.actions.serverEventActions.addEvent(pair); //Pair(channelId, errorServerEvent));
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
        final String validateNameMess = common_tools.checkChannelName(channelName);
        final String validateShortNameMess = common_tools.checkChannelShortName(channelShortName);
        final String validateWsUrl = common_tools.checkWsUrl(wsUrl);

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
}
