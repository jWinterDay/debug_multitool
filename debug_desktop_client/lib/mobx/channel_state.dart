import 'dart:convert';

import 'package:debug_desktop_client/app_di.dart';
import 'package:debug_desktop_client/services/custom/channel_service.dart';
import 'package:flutter/widgets.dart';
import 'package:mobx/mobx.dart';
import 'channel.dart';
import 'connect_status.dart';

part 'channel_state.g.dart';

class ChannelState extends _ChannelState with _$ChannelState {
  String toJson() => json.encode(toMap());

  static List<Channel> fromList(List<Map<String, dynamic>> list) {
    return list.map((Map<String, dynamic> element) => Channel.fromMap(element)).toList();
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'channelList': channelList.map((Channel channel) => channel.toMap()).toList(),
    };
  }
}

abstract class _ChannelState with Store {
  ChannelService _channelService = di.get<ChannelService>();

  @observable
  Channel currentChannel;

  @observable
  ObservableList<Channel> channelList = ObservableList<Channel>();

  @computed
  ObservableList<Channel> get connectedChannels {
    return ObservableList<Channel>.of(channelList.where((Channel channel) {
      return channel.connectStatus == ConnectStatus.connected;
    }));
  }

  Channel getChannelByName(String name) {
    return channelList.singleWhere((Channel channel) {
      return channel.name == name;
    }, orElse: () => null);
  }

  Future<void> fetch() async {
    List<Channel> list = await _channelService.fetch();

    addChannelState(list);
  }

  @action
  String addChannel(String name) {
    final bool exists = channelList.any((Channel ch) => ch.name == name);

    if (exists) {
      return 'Channel with name $name already exists';
    }

    final Channel channel = Channel()..name = name;

    channelList.add(channel);

    // save to db
    _channelService.add(channel);

    return null;
  }

  @action
  void addChannelState(List<Channel> list) {
    channelList.addAll(list);
  }

  @action
  void removeChannel(Channel channel) {
    getChannelByName(channel.name).setConnected(isConnected: false);
    channelList.removeWhere((Channel ch) {
      return ch.name == channel.name;
    });

    _channelService.delete(channel);
  }

  @action
  void clearChannelState() {
    channelList.forEach((Channel channel) {
      channel.setConnected(isConnected: false);
    });

    channelList.clear();

    // delete all channels from db
    _channelService.deleteAll();
  }

  @action
  void setConnected(Channel channel, {@required bool connected}) {
    // delegate set connected to channel
    channel.setConnected(isConnected: connected);
  }

  @action
  void setCurrentChannel(Channel channel) {
    currentChannel = channel;
  }

  @action
  void setChannelUrl(Channel channel, String url) {
    // delegate set connected to channel
    channel.setChannelUrl(url);
  }
}
