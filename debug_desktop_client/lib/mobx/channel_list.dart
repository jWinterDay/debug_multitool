import 'dart:convert';

import 'package:debug_desktop_client/mobx/services/channel_service.dart';
import 'package:flutter/widgets.dart';
import 'package:mobx/mobx.dart';
import 'channel.dart';

part 'channel_list.g.dart';

ChannelService _channelService = ChannelService();

class ChannelList extends _ChannelList with _$ChannelList {
  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'channelList': channelList.map((Channel channel) => channel.toMap()).toList(),
    };
  }
}

abstract class _ChannelList with Store {
  @observable
  Channel currentChannel;

  @observable
  ObservableList<Channel> channelList = ObservableList<Channel>();

  @computed
  ObservableList<Channel> get connectedChannels {
    return ObservableList<Channel>.of(channelList.where((Channel channel) {
      return channel.connected;
    }));
  }

  Channel getChannelByName(String name) {
    return channelList.singleWhere((Channel channel) {
      return channel.name == name;
    }, orElse: () => null);
  }

  Future<void> fetch() async {
    _channelService.fetch().then((value) {
      print('value = $value');
    });
  }

  Future<void> _addToDb(Channel channel) async {
    _channelService.add(channel);
  }

  Future<void> _deleteFromDb(Channel channel) async {
    _channelService.delete(channel);
  }

  @action
  String addChannel(String name) {
    final bool exists = channelList.any((Channel ch) => ch.name == name);

    if (exists) {
      return 'Channel with this name already exists';
    }

    final Channel channel = Channel()..name = name;

    channelList.add(channel);

    // save to db
    _addToDb(channel);

    return null;
  }

  @action
  void addChannelList(List<String> list) {
    list.forEach((String name) {
      addChannel(name);
    });
  }

  @action
  void removeChannel(Channel channel) {
    getChannelByName(channel.name).setConnected(isConnected: false);
    channelList.removeWhere((Channel ch) {
      return ch.name == channel.name;
    });

    _deleteFromDb(channel);
  }

  @action
  void clearChannelList() {
    channelList.clear();
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
