import 'dart:async';
import 'dart:convert';

import 'package:debug_desktop_client/app_di.dart';
import 'package:debug_desktop_client/mobx/log.dart';
import 'package:debug_desktop_client/services/logger_service.dart';
import 'package:mobx/mobx.dart';
import 'package:centrifuge/centrifuge.dart' as centrifuge;

import 'connect_status.dart';
import 'services/channel_service.dart';

part 'channel.g.dart';

LoggerService loggerService = di.get<LoggerService>();
ChannelService _channelService = ChannelService();

class Channel extends _Channel with _$Channel {
  String toJson() => json.encode(toMap());

  static _Channel fromJson(String str) => fromMap(json.decode(str) as Map<String, dynamic>);

  static Channel fromMap(Map<String, dynamic> json) {
    return Channel()
      ..wsUrl = (json['wsUrl'] as String)
      ..name = (json['name'] as String)
      ..description = (json['description'] as String)
      ..isWhiteListUsed = (json['isWhiteListUsed'] as bool)
      ..filterWhiteList = (json['filterWhiteList'] as String)
      ..isBlackListUsed = (json['isBlackListUsed'] as bool)
      ..filterBlackList = (json['filterBlackList'] as String);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'wsUrl': wsUrl,
      'name': name,
      'description': description,
      'isWhiteListUsed': isWhiteListUsed,
      'filterWhiteList': filterWhiteList,
      'isBlackListUsed': isBlackListUsed,
      'filterBlackList': filterBlackList,
    };
  }
}

abstract class _Channel with Store {
  @observable
  DateTime datetime;

  @observable
  String wsUrl = 'ws://localhost:8001/connection/websocket?format=protobuf';

  /// channel name
  @observable
  String name;

  @observable
  String description;

  @observable
  bool connected = false;

  @computed
  List<Log> get filteredLogs {
    return logs.where((Log log) {
      // white
      if (isWhiteListUsed) {
        return log.action.contains(filterWhiteList);
      }

      return true;
    }).where((Log log) {
      if (isBlackListUsed) {
        return filterBlackList == '' || !log.action.contains(filterBlackList);
      }

      return true;
    }).toList();
  }

  @observable
  ObservableList<Log> logs = ObservableList<Log>();

  // white list
  @observable
  bool isWhiteListUsed = true;
  @observable
  String filterWhiteList = '';

  // black list
  @observable
  bool isBlackListUsed = false;
  @observable
  String filterBlackList = '';

  @action
  void setChannelUrl(String url) {
    wsUrl = url;
    _channelService.update(this);
  }

  @action
  void addLog(Log log) => logs.add(log);

  @action
  void clearLogs() => logs.clear();

  @action
  void setFilterWhite(String filter) {
    filterWhiteList = filter;

    _channelService.update(this);
  }

  @action
  void setFilterBlack(String filter) {
    filterBlackList = filter;

    _channelService.update(this);
  }

  @action
  void useWhiteList(bool val) {
    isWhiteListUsed = val;

    _channelService.update(this);
  }

  @action
  void useBlackList(bool val) {
    isBlackListUsed = val;

    _channelService.update(this);
  }

  // centrifugo
  @observable
  ConnectStatus connectStatus = ConnectStatus.disconnected;

  @observable
  centrifuge.Client client;

  @observable
  centrifuge.Subscription subscription;

  @observable
  StreamSubscription<centrifuge.ConnectEvent> _connectSub;

  @observable
  StreamSubscription<centrifuge.DisconnectEvent> _disconnectSub;

  @observable
  StreamSubscription<centrifuge.PublishEvent> _publishSub;

  final JsonEncoder _encoder = const JsonEncoder.withIndent('   ');
  String _exceptionStub(String message) {
    return '''
      Parse error. Use next format:
        {
          "action": "action1",
          "payload": {
            "name":"name1",
            "pl": "pl1"
          },
        "state": "state1"
        }

      message: $message
    ''';
  }

  @action
  void setConnected({bool isConnected}) {
    if (isConnected) {
      connectStatus = ConnectStatus.connecting;
      client = centrifuge.createClient(wsUrl);
      subscription = client.getSubscription(name);

      // connect sub
      _connectSub = client.connectStream.listen((centrifuge.ConnectEvent event) {
        connectStatus = ConnectStatus.connected;

        final Log log = Log(
          action: 'connect',
          actionPayload: 'client: ${event.client}, version: ${event.version}',
        );

        addLog(log);
      });
      // disconnect sub
      _disconnectSub = client.disconnectStream.listen((centrifuge.DisconnectEvent event) {
        connectStatus = ConnectStatus.disconnected;

        final Log log = Log(
          action: 'disconnect',
          actionPayload: 'reason: ${event.reason}, shouldReconnect: ${event.shouldReconnect}',
        );
        addLog(log);
      });
      // publish sub
      _publishSub = subscription.publishStream.listen((centrifuge.PublishEvent event) {
        //example: {"action": "action1", "payload": {"name":"name1", "pl": "pl1"}, "state": "state1"}
        final dynamic message = json.decode(utf8.decode(event.data));
        String prettyActionPayload;
        String prettyState;
        String action;

        try {
          action = message['action'].toString();
          final String actionPayload = message['payload'].toString();
          final String state = message['state'].toString();

          // calc
          action ??= 'unknown action';
          prettyActionPayload =
              actionPayload == null ? _exceptionStub(message.toString()) : _encoder.convert(actionPayload);

          prettyState = state == null ? _exceptionStub(message.toString()) : _encoder.convert(state);
        } catch (exc) {
          loggerService.e('publishStream. exc: $exc');
        }

        final Log log = Log(
          action: action,
          actionPayload: prettyActionPayload,
          state: prettyState,
        );
        addLog(log);
      });

      // subscription.joinStream.listen((centrifuge.JoinEvent event) {
      //   print('joinStream event = ${event.client}, ${event.user}');
      // });
      // subscription.leaveStream.listen((centrifuge.LeaveEvent event) {
      //   print('leaveStream event = ${event.client}, ${event.user}');
      // });
      // subscription.subscribeSuccessStream.listen((centrifuge.SubscribeSuccessEvent event) {
      //   print(
      //       'subscribeSuccessStream event isRecovered = ${event.isRecovered}, isResubscribed = ${event.isResubscribed}');
      // });
      // subscription.subscribeErrorStream.listen((centrifuge.SubscribeErrorEvent event) {
      //   print('subscribeErrorStream event code = ${event.code}, message = ${event.message}');
      // });
      // subscription.unsubscribeStream.listen((centrifuge.UnsubscribeEvent event) {
      //   print('unsubscribeStream event');
      // });

      // connect
      subscription.subscribe();
      client.connect();
    } else {
      if (connectStatus == ConnectStatus.connected) {
        client?.disconnect();
      }

      Future<void>.delayed(const Duration(milliseconds: 200), () {
        _connectSub?.cancel();
        _disconnectSub?.cancel();
        _publishSub?.cancel();
      });
      subscription?.unsubscribe();
      connectStatus = ConnectStatus.disconnected;
      client = null;
    }

    connected = isConnected;
  }
}
