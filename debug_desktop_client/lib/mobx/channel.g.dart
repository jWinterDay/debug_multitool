// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'channel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$Channel on _Channel, Store {
  Computed<List<LogState>> _$filteredLogsComputed;

  @override
  List<LogState> get filteredLogs => (_$filteredLogsComputed ??=
          Computed<List<LogState>>(() => super.filteredLogs,
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

  final _$logStatesAtom = Atom(name: '_Channel.logStates');

  @override
  ObservableList<LogState> get logStates {
    _$logStatesAtom.reportRead();
    return super.logStates;
  }

  @override
  set logStates(ObservableList<LogState> value) {
    _$logStatesAtom.reportWrite(value, super.logStates, () {
      super.logStates = value;
    });
  }

  final _$isFavoriteOnlyAtom = Atom(name: '_Channel.isFavoriteOnly');

  @override
  bool get isFavoriteOnly {
    _$isFavoriteOnlyAtom.reportRead();
    return super.isFavoriteOnly;
  }

  @override
  set isFavoriteOnly(bool value) {
    _$isFavoriteOnlyAtom.reportWrite(value, super.isFavoriteOnly, () {
      super.isFavoriteOnly = value;
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

  final _$whiteListAtom = Atom(name: '_Channel.whiteList');

  @override
  ObservableSet<String> get whiteList {
    _$whiteListAtom.reportRead();
    return super.whiteList;
  }

  @override
  set whiteList(ObservableSet<String> value) {
    _$whiteListAtom.reportWrite(value, super.whiteList, () {
      super.whiteList = value;
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

  final _$blackListAtom = Atom(name: '_Channel.blackList');

  @override
  ObservableSet<String> get blackList {
    _$blackListAtom.reportRead();
    return super.blackList;
  }

  @override
  set blackList(ObservableSet<String> value) {
    _$blackListAtom.reportWrite(value, super.blackList, () {
      super.blackList = value;
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

  final _$_ChannelActionController = ActionController(name: '_Channel');

  @override
  void setFavoriteOnly() {
    final _$actionInfo = _$_ChannelActionController.startAction(
        name: '_Channel.setFavoriteOnly');
    try {
      return super.setFavoriteOnly();
    } finally {
      _$_ChannelActionController.endAction(_$actionInfo);
    }
  }

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
  void addLog(LogState logState) {
    final _$actionInfo =
        _$_ChannelActionController.startAction(name: '_Channel.addLog');
    try {
      return super.addLog(logState);
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
  void addWhiteListItem(String filter) {
    final _$actionInfo = _$_ChannelActionController.startAction(
        name: '_Channel.addWhiteListItem');
    try {
      return super.addWhiteListItem(filter);
    } finally {
      _$_ChannelActionController.endAction(_$actionInfo);
    }
  }

  @override
  void removeWhiteListItem(String filter) {
    final _$actionInfo = _$_ChannelActionController.startAction(
        name: '_Channel.removeWhiteListItem');
    try {
      return super.removeWhiteListItem(filter);
    } finally {
      _$_ChannelActionController.endAction(_$actionInfo);
    }
  }

  @override
  void addBlackListItem(String filter) {
    final _$actionInfo = _$_ChannelActionController.startAction(
        name: '_Channel.addBlackListItem');
    try {
      return super.addBlackListItem(filter);
    } finally {
      _$_ChannelActionController.endAction(_$actionInfo);
    }
  }

  @override
  void removeBlackListItem(String filter) {
    final _$actionInfo = _$_ChannelActionController.startAction(
        name: '_Channel.removeBlackListItem');
    try {
      return super.removeBlackListItem(filter);
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
logStates: ${logStates},
isFavoriteOnly: ${isFavoriteOnly},
isWhiteListUsed: ${isWhiteListUsed},
filterWhiteList: ${filterWhiteList},
whiteList: ${whiteList},
isBlackListUsed: ${isBlackListUsed},
filterBlackList: ${filterBlackList},
blackList: ${blackList},
connectStatus: ${connectStatus},
client: ${client},
subscription: ${subscription},
filteredLogs: ${filteredLogs}
    ''';
  }
}
