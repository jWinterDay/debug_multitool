// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'channel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$Channel on _Channel, Store {
  Computed<List<Log>> _$filteredLogsComputed;

  @override
  List<Log> get filteredLogs =>
      (_$filteredLogsComputed ??= Computed<List<Log>>(() => super.filteredLogs,
              name: '_Channel.filteredLogs'))
          .value;

  final _$datetimeAtom = Atom(name: '_Channel.datetime');

  @override
  DateTime get datetime {
    _$datetimeAtom.reportRead();
    return super.datetime;
  }

  @override
  set datetime(DateTime value) {
    _$datetimeAtom.reportWrite(value, super.datetime, () {
      super.datetime = value;
    });
  }

  final _$wsUrlAtom = Atom(name: '_Channel.wsUrl');

  @override
  String get wsUrl {
    _$wsUrlAtom.reportRead();
    return super.wsUrl;
  }

  @override
  set wsUrl(String value) {
    _$wsUrlAtom.reportWrite(value, super.wsUrl, () {
      super.wsUrl = value;
    });
  }

  final _$nameAtom = Atom(name: '_Channel.name');

  @override
  String get name {
    _$nameAtom.reportRead();
    return super.name;
  }

  @override
  set name(String value) {
    _$nameAtom.reportWrite(value, super.name, () {
      super.name = value;
    });
  }

  final _$descriptionAtom = Atom(name: '_Channel.description');

  @override
  String get description {
    _$descriptionAtom.reportRead();
    return super.description;
  }

  @override
  set description(String value) {
    _$descriptionAtom.reportWrite(value, super.description, () {
      super.description = value;
    });
  }

  final _$connectedAtom = Atom(name: '_Channel.connected');

  @override
  bool get connected {
    _$connectedAtom.reportRead();
    return super.connected;
  }

  @override
  set connected(bool value) {
    _$connectedAtom.reportWrite(value, super.connected, () {
      super.connected = value;
    });
  }

  final _$logsAtom = Atom(name: '_Channel.logs');

  @override
  ObservableList<Log> get logs {
    _$logsAtom.reportRead();
    return super.logs;
  }

  @override
  set logs(ObservableList<Log> value) {
    _$logsAtom.reportWrite(value, super.logs, () {
      super.logs = value;
    });
  }

  final _$isWhiteListUsedAtom = Atom(name: '_Channel.isWhiteListUsed');

  @override
  bool get isWhiteListUsed {
    _$isWhiteListUsedAtom.reportRead();
    return super.isWhiteListUsed;
  }

  @override
  set isWhiteListUsed(bool value) {
    _$isWhiteListUsedAtom.reportWrite(value, super.isWhiteListUsed, () {
      super.isWhiteListUsed = value;
    });
  }

  final _$filterWhiteListAtom = Atom(name: '_Channel.filterWhiteList');

  @override
  String get filterWhiteList {
    _$filterWhiteListAtom.reportRead();
    return super.filterWhiteList;
  }

  @override
  set filterWhiteList(String value) {
    _$filterWhiteListAtom.reportWrite(value, super.filterWhiteList, () {
      super.filterWhiteList = value;
    });
  }

  final _$isBlackListUsedAtom = Atom(name: '_Channel.isBlackListUsed');

  @override
  bool get isBlackListUsed {
    _$isBlackListUsedAtom.reportRead();
    return super.isBlackListUsed;
  }

  @override
  set isBlackListUsed(bool value) {
    _$isBlackListUsedAtom.reportWrite(value, super.isBlackListUsed, () {
      super.isBlackListUsed = value;
    });
  }

  final _$filterBlackListAtom = Atom(name: '_Channel.filterBlackList');

  @override
  String get filterBlackList {
    _$filterBlackListAtom.reportRead();
    return super.filterBlackList;
  }

  @override
  set filterBlackList(String value) {
    _$filterBlackListAtom.reportWrite(value, super.filterBlackList, () {
      super.filterBlackList = value;
    });
  }

  final _$connectStatusAtom = Atom(name: '_Channel.connectStatus');

  @override
  ConnectStatus get connectStatus {
    _$connectStatusAtom.reportRead();
    return super.connectStatus;
  }

  @override
  set connectStatus(ConnectStatus value) {
    _$connectStatusAtom.reportWrite(value, super.connectStatus, () {
      super.connectStatus = value;
    });
  }

  final _$clientAtom = Atom(name: '_Channel.client');

  @override
  centrifuge.Client get client {
    _$clientAtom.reportRead();
    return super.client;
  }

  @override
  set client(centrifuge.Client value) {
    _$clientAtom.reportWrite(value, super.client, () {
      super.client = value;
    });
  }

  final _$subscriptionAtom = Atom(name: '_Channel.subscription');

  @override
  centrifuge.Subscription get subscription {
    _$subscriptionAtom.reportRead();
    return super.subscription;
  }

  @override
  set subscription(centrifuge.Subscription value) {
    _$subscriptionAtom.reportWrite(value, super.subscription, () {
      super.subscription = value;
    });
  }

  final _$_connectSubAtom = Atom(name: '_Channel._connectSub');

  @override
  StreamSubscription<centrifuge.ConnectEvent> get _connectSub {
    _$_connectSubAtom.reportRead();
    return super._connectSub;
  }

  @override
  set _connectSub(StreamSubscription<centrifuge.ConnectEvent> value) {
    _$_connectSubAtom.reportWrite(value, super._connectSub, () {
      super._connectSub = value;
    });
  }

  final _$_disconnectSubAtom = Atom(name: '_Channel._disconnectSub');

  @override
  StreamSubscription<centrifuge.DisconnectEvent> get _disconnectSub {
    _$_disconnectSubAtom.reportRead();
    return super._disconnectSub;
  }

  @override
  set _disconnectSub(StreamSubscription<centrifuge.DisconnectEvent> value) {
    _$_disconnectSubAtom.reportWrite(value, super._disconnectSub, () {
      super._disconnectSub = value;
    });
  }

  final _$_publishSubAtom = Atom(name: '_Channel._publishSub');

  @override
  StreamSubscription<centrifuge.PublishEvent> get _publishSub {
    _$_publishSubAtom.reportRead();
    return super._publishSub;
  }

  @override
  set _publishSub(StreamSubscription<centrifuge.PublishEvent> value) {
    _$_publishSubAtom.reportWrite(value, super._publishSub, () {
      super._publishSub = value;
    });
  }

  final _$_ChannelActionController = ActionController(name: '_Channel');

  @override
  void setChannelUrl(String url) {
    final _$actionInfo =
        _$_ChannelActionController.startAction(name: '_Channel.setChannelUrl');
    try {
      return super.setChannelUrl(url);
    } finally {
      _$_ChannelActionController.endAction(_$actionInfo);
    }
  }

  @override
  void addLog(Log log) {
    final _$actionInfo =
        _$_ChannelActionController.startAction(name: '_Channel.addLog');
    try {
      return super.addLog(log);
    } finally {
      _$_ChannelActionController.endAction(_$actionInfo);
    }
  }

  @override
  void clearLogs() {
    final _$actionInfo =
        _$_ChannelActionController.startAction(name: '_Channel.clearLogs');
    try {
      return super.clearLogs();
    } finally {
      _$_ChannelActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setFilterWhite(String filter) {
    final _$actionInfo =
        _$_ChannelActionController.startAction(name: '_Channel.setFilterWhite');
    try {
      return super.setFilterWhite(filter);
    } finally {
      _$_ChannelActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setFilterBlack(String filter) {
    final _$actionInfo =
        _$_ChannelActionController.startAction(name: '_Channel.setFilterBlack');
    try {
      return super.setFilterBlack(filter);
    } finally {
      _$_ChannelActionController.endAction(_$actionInfo);
    }
  }

  @override
  void useWhiteList(bool val) {
    final _$actionInfo =
        _$_ChannelActionController.startAction(name: '_Channel.useWhiteList');
    try {
      return super.useWhiteList(val);
    } finally {
      _$_ChannelActionController.endAction(_$actionInfo);
    }
  }

  @override
  void useBlackList(bool val) {
    final _$actionInfo =
        _$_ChannelActionController.startAction(name: '_Channel.useBlackList');
    try {
      return super.useBlackList(val);
    } finally {
      _$_ChannelActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setConnected({bool isConnected}) {
    final _$actionInfo =
        _$_ChannelActionController.startAction(name: '_Channel.setConnected');
    try {
      return super.setConnected(isConnected: isConnected);
    } finally {
      _$_ChannelActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
datetime: ${datetime},
wsUrl: ${wsUrl},
name: ${name},
description: ${description},
connected: ${connected},
logs: ${logs},
isWhiteListUsed: ${isWhiteListUsed},
filterWhiteList: ${filterWhiteList},
isBlackListUsed: ${isBlackListUsed},
filterBlackList: ${filterBlackList},
connectStatus: ${connectStatus},
client: ${client},
subscription: ${subscription},
filteredLogs: ${filteredLogs}
    ''';
  }
}
