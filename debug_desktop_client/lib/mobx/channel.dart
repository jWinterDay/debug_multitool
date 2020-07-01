import 'dart:async';
import 'dart:convert';

import 'package:debug_desktop_client/app_di.dart';
import 'package:debug_desktop_client/mobx/log.dart';
import 'package:debug_desktop_client/mobx/log_state.dart';
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
      ..wsUrl = json['wsUrl'].toString()
      ..name = json['name'].toString()
      ..description = json['description'].toString()
      ..isWhiteListUsed = json['isWhiteListUsed'] == 1
      ..filterWhiteList = json['filterWhiteList'].toString() ?? ''
      ..isBlackListUsed = json['isBlackListUsed'] == 1
      ..filterBlackList = json['filterBlackList'].toString() ?? '';
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
  final ChannelService _channelService = di.get<ChannelService>();
  final LoggerService _loggerService = di.get<LoggerService>();

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
  List<LogState> get filteredLogs {
    if (isFavoriteOnly) {
      return logStates.where((LogState logState) {
        return logState.isFavorite;
      }).toList();
    }

    return logStates.where((LogState logState) {
      // white
      if (isWhiteListUsed) {
        return whiteList.isEmpty || whiteList.contains(logState.log.action);
      }

      return true;
    }).where((LogState logState) {
      if (isBlackListUsed) {
        return blackList.isEmpty || !blackList.contains(logState.log.action);
      }

      return true;
    }).toList();
  }

  @observable
  ObservableList<LogState> logStates = ObservableList<LogState>();

  // favorite list
  @observable
  bool isFavoriteOnly = false;

  // white list
  @observable
  bool isWhiteListUsed = true;
  @deprecated
  @observable
  String filterWhiteList = '';
  @observable
  ObservableSet<String> whiteList = ObservableSet<String>();

  // black list
  @observable
  bool isBlackListUsed = false;
  @deprecated
  @observable
  String filterBlackList = '';
  @observable
  ObservableSet<String> blackList = ObservableSet<String>();

  @action
  void setFavoriteOnly() {
    isFavoriteOnly = !isFavoriteOnly;
  }

  @action
  void setChannelUrl(String url) {
    wsUrl = url;
    // ignore: argument_type_not_assignable
    _channelService.update(this as Channel);
  }

  @action
  void addLog(LogState logState) => logStates.add(logState);

  @action
  void clearLogs() => logStates.clear();

  // white and black filters
  @action
  void useWhiteList(bool val) {
    isWhiteListUsed = val;

    _channelService.update(this as Channel);
  }

  @action
  void useBlackList(bool val) {
    isBlackListUsed = val;

    _channelService.update(this as Channel);
  }

  @action
  void addWhiteListItem(String filter) => whiteList.add(filter);

  @action
  void removeWhiteListItem(String filter) => whiteList.remove(filter);

  @action
  void addBlackListItem(String filter) => blackList.add(filter);

  @action
  void removeBlackListItem(String filter) => blackList.remove(filter);

  // ----------------- remove old
  @deprecated
  @action
  void setFilterWhite(String filter) {
    filterWhiteList = filter;

    _channelService.update(this as Channel);
  }

  @deprecated
  @action
  void setFilterBlack(String filter) {
    filterBlackList = filter;

    _channelService.update(this as Channel);
  }

  // centrifugo
  @observable
  ConnectStatus connectStatus = ConnectStatus.disconnected;

  @observable
  centrifuge.Client client;

  @observable
  centrifuge.Subscription subscription;

  // @observable
  StreamSubscription<centrifuge.ConnectEvent> _connectSub;

  // @observable
  StreamSubscription<centrifuge.DisconnectEvent> _disconnectSub;

  // @observable
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
          id: logStates.length,
          action: 'connect',
          actionPayload: 'client: ${event.client}, version: ${event.version}',
          prevLog: logStates.isEmpty ? null : logStates.last.log,
        );

        addLog(LogState(log));
      });
      // disconnect sub
      _disconnectSub = client.disconnectStream.listen((centrifuge.DisconnectEvent event) {
        connectStatus = ConnectStatus.disconnected;

        final Log log = Log(
          id: logStates.length,
          action: 'disconnect',
          actionPayload: 'reason: ${event.reason}, shouldReconnect: ${event.shouldReconnect}',
          prevLog: logStates.isEmpty ? null : logStates.last.log,
        );
        addLog(LogState(log));
      });
      // publish sub
      _publishSub = subscription.publishStream.listen((centrifuge.PublishEvent event) {
        //example: {"action": "action1", "payload": {"name":"name1", "pl": "pl1"}, "state": "state1"}
        final Map<String, dynamic> message = json.decode(utf8.decode(event.data)) as Map<String, dynamic>;
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
          id: logStates.length,
          action: action,
          actionPayload: prettyActionPayload,
          state: prettyState,
          prevLog: logStates.isEmpty ? null : logStates.last.log,
        );
        addLog(LogState(log));
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
