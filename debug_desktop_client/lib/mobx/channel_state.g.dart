// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'channel_state.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ChannelState on _ChannelState, Store {
  Computed<ObservableList<Channel>> _$connectedChannelsComputed;

  @override
  ObservableList<Channel> get connectedChannels =>
      (_$connectedChannelsComputed ??= Computed<ObservableList<Channel>>(
              () => super.connectedChannels,
              name: '_ChannelState.connectedChannels'))
          .value;

  final _$currentChannelAtom = Atom(name: '_ChannelState.currentChannel');

  @override
  Channel get currentChannel {
    _$currentChannelAtom.reportRead();
    return super.currentChannel;
  }

  @override
  set currentChannel(Channel value) {
    _$currentChannelAtom.reportWrite(value, super.currentChannel, () {
      super.currentChannel = value;
    });
  }

  final _$channelListAtom = Atom(name: '_ChannelState.channelList');

  @override
  ObservableList<Channel> get channelList {
    _$channelListAtom.reportRead();
    return super.channelList;
  }

  @override
  set channelList(ObservableList<Channel> value) {
    _$channelListAtom.reportWrite(value, super.channelList, () {
      super.channelList = value;
    });
  }

  final _$_ChannelStateActionController =
      ActionController(name: '_ChannelState');

  @override
  String addChannel(String name) {
    final _$actionInfo = _$_ChannelStateActionController.startAction(
        name: '_ChannelState.addChannel');
    try {
      return super.addChannel(name);
    } finally {
      _$_ChannelStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  void addChannelState(List<Channel> list) {
    final _$actionInfo = _$_ChannelStateActionController.startAction(
        name: '_ChannelState.addChannelState');
    try {
      return super.addChannelState(list);
    } finally {
      _$_ChannelStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  void removeChannel(Channel channel) {
    final _$actionInfo = _$_ChannelStateActionController.startAction(
        name: '_ChannelState.removeChannel');
    try {
      return super.removeChannel(channel);
    } finally {
      _$_ChannelStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  void clearChannelState() {
    final _$actionInfo = _$_ChannelStateActionController.startAction(
        name: '_ChannelState.clearChannelState');
    try {
      return super.clearChannelState();
    } finally {
      _$_ChannelStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setConnected(Channel channel, {@required bool connected}) {
    final _$actionInfo = _$_ChannelStateActionController.startAction(
        name: '_ChannelState.setConnected');
    try {
      return super.setConnected(channel, connected: connected);
    } finally {
      _$_ChannelStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setCurrentChannel(Channel channel) {
    final _$actionInfo = _$_ChannelStateActionController.startAction(
        name: '_ChannelState.setCurrentChannel');
    try {
      return super.setCurrentChannel(channel);
    } finally {
      _$_ChannelStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setChannelUrl(Channel channel, String url) {
    final _$actionInfo = _$_ChannelStateActionController.startAction(
        name: '_ChannelState.setChannelUrl');
    try {
      return super.setChannelUrl(channel, url);
    } finally {
      _$_ChannelStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
currentChannel: ${currentChannel},
channelList: ${channelList},
connectedChannels: ${connectedChannels}
    ''';
  }
}
