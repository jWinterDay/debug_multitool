import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:mobx/mobx.dart';
import 'channel.dart';

part 'channel_list.g.dart';

class ChannelList extends _ChannelList with _$ChannelList {
  static ChannelList fromJson(String str) => ChannelList.fromMap(json.decode(str) as Map<String, dynamic>);

  String toJson() => json.encode(toMap());

  static ChannelList fromMap(Map<String, dynamic> json) {
    // final List<dynamic> t = json['channelList'] as List<dynamic>;
    // t.forEach((dynamic element) {
    //   final Map<String, dynamic> m = element as Map<String, dynamic>;
    //   print('${element.runtimeType} >>>> $m ');
    // });

    final ObservableList<Channel> calcList = () {
      ObservableList<Channel> channelList;
      if (json['channelList'] == null) {
        return null;
      }

      return null;
    }();

    return ChannelList()..channelList = calcList; //json['channelList'] == null ? null : ObservableList<Channel>();
  }

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

  @action
  String addChannel(String name) {
    final bool exists = channelList.any((Channel ch) => ch.name == name);

    if (exists) {
      return 'Channel with this name already exists';
    }

    channelList.add(Channel()..name = name);

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
    channelList.removeWhere((Channel ch) {
      return ch.name == channel.name;
    });
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
    channel.wsUrl = url;
  }
}
