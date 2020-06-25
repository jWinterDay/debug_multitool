import 'dart:async';
import 'dart:convert';

import 'package:debug_desktop_client/app_di.dart';
import 'package:debug_desktop_client/mobx/log.dart';
import 'package:debug_desktop_client/services/custom/channel_service.dart';
import 'package:debug_desktop_client/services/logger_service.dart';
import 'package:mobx/mobx.dart';
import 'package:centrifuge/centrifuge.dart' as centrifuge;

import 'connect_status.dart';

part 'channel.g.dart';

// LoggerService _loggerService = di.get<LoggerService>();

class Channel extends _Channel with _$Channel {
  String toJson() => json.encode(toMap());

  static _Channel fromJson(String str) => fromMap(json.decode(str) as Map<String, dynamic>);

  static Channel fromMap(Map<String, dynamic> json) {
    return Channel()
      ..wsUrl = json['wsUrl']
      ..name = json['name']
      ..description = json['description']
      ..isWhiteListUsed = json['isWhiteListUsed'] == 1
      ..filterWhiteList = json['filterWhiteList'] ?? ''
      ..isBlackListUsed = json['isBlackListUsed'] == 1
      ..filterBlackList = json['filterBlackList'] ?? '';
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
  ChannelService _channelService = di.get<ChannelService>();
  LoggerService _loggerService = di.get<LoggerService>();

  @observable
  DateTime datetime;

  @observable
  String wsUrl = 'ws://172.16.55.141:8001/connection/websocket?format=protobuf';

  /// channel name
  @observable
  String name;

  @observable
  String description;

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
          id: logs.length,
          action: 'connect',
          actionPayload: 'client: ${event.client}, version: ${event.version}',
          prevLog: logs.isEmpty ? null : logs.last,
        );

        addLog(log);
      });
      // disconnect sub
      _disconnectSub = client.disconnectStream.listen((centrifuge.DisconnectEvent event) {
        connectStatus = ConnectStatus.disconnected;

        final Log log = Log(
          id: logs.length,
          action: 'disconnect',
          actionPayload: 'reason: ${event.reason}, shouldReconnect: ${event.shouldReconnect}',
          prevLog: logs.isEmpty ? null : logs.last,
        );
        addLog(log);
      });
      // publish sub
      _publishSub = subscription.publishStream.listen((centrifuge.PublishEvent event) {
        //example: {"action": "action1", "payload": {"name":"name1", "pl": "pl1"}, "state": "state1"}
        final Map<String, dynamic> message = json.decode(utf8.decode(event.data));
        String prettyActionPayload = 'unknown action payload';
        String prettyState = 'unknown state';
        String action = 'unknown action';

        try {
          action = message['action']?.toString() ?? 'unknown action';
          final dynamic rawPayload = message['payload'];
          final dynamic rawState = message['state'];

          prettyActionPayload = _encoder.convert(rawPayload);
          prettyState = _encoder.convert(rawState);
        } catch (exc) {
          _loggerService.e('publishStream. exc: $exc');
        }

        final Log log = Log(
          id: logs.length,
          action: action,
          actionPayload: prettyActionPayload,
          state: prettyState,
          prevLog: logs.isEmpty ? null : logs.last,
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
  }
}
