import 'dart:async';
import 'dart:convert';

import 'package:debug_desktop_client/app_di.dart';
import 'package:debug_desktop_client/mobx/log_state.dart';
import 'package:debug_desktop_client/services/centrifugo_service.dart';
import 'package:debug_desktop_client/services/custom/channel_service.dart';
import 'package:mobx/mobx.dart';

import 'connect_status.dart';

part 'channel.g.dart';

class Channel extends _Channel with _$Channel {
  String toJson() => json.encode(toMap());

  static _Channel fromJson(String str) => fromMap(json.decode(str) as Map<String, dynamic>);

  static Channel fromMap(Map<String, dynamic> json) {
    return Channel()
      ..channelId = int.tryParse(json['channelId'].toString())
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
      'channelId': channelId,
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
  _Channel() {
    _centrifugoService = CentrifugoService(this as Channel);
    _connectStatusSub = _centrifugoService.connectStatusStream.listen((ConnectStatus status) {
      connectStatus = status;
    });
  }

  final ChannelService _channelService = di.get<ChannelService>();
  CentrifugoService _centrifugoService;
  StreamSubscription<ConnectStatus> _connectStatusSub;

  @observable
  ConnectStatus connectStatus;

  int channelId;

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

  @computed
  Set<String> get whiteListTyped {
    return whiteList.toSet();
  }

  @computed
  Set<String> get blackListTyped {
    return blackList.toSet();
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
  void addWhiteListItem(String filter) {
    whiteList.add(filter);

    _channelService.addFilter(name, filter, isWhite: true);
  }

  @action
  void addWhiteList(List<String> list) => whiteList.addAll(list);

  @action
  void removeWhiteListItem(String filter) {
    whiteList.remove(filter);

    _channelService.removeFilter(name, filter, isWhite: true);
  }

  @action
  void addBlackListItem(String filter) {
    blackList.add(filter);

    _channelService.addFilter(name, filter, isWhite: false);
  }

  @action
  void addBlackList(List<String> list) => blackList.addAll(list);

  @action
  void removeBlackListItem(String filter) {
    blackList.remove(filter);

    _channelService.removeFilter(name, filter, isWhite: false);
  }

  @action
  void setConnected({bool isConnected}) {
    if (isConnected) {
      _centrifugoService.connect();
      return;
    }

    _centrifugoService.disconnect();
  }

  /// send log state back to centrifugo
  @action
  void sendLogStateBack(LogState logState) {
    _centrifugoService.sendLogState(logState);
  }

  void dispose() {
    _connectStatusSub.cancel();
    _centrifugoService.dispose();
  }
}
