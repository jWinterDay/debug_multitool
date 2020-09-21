// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'channel_actions.dart';

// **************************************************************************
// BuiltReduxGenerator
// **************************************************************************

// ignore_for_file: avoid_classes_with_only_static_members
// ignore_for_file: annotate_overrides
// ignore_for_file: overridden_fields
// ignore_for_file: type_annotate_public_apis

class _$ChannelActions extends ChannelActions {
  factory _$ChannelActions() => _$ChannelActions._();
  _$ChannelActions._() : super._();

  final addChannel = ActionDispatcher<ChannelModel>('ChannelActions-addChannel');
  final addAllChannel = ActionDispatcher<Iterable<ChannelModel>>('ChannelActions-addAllChannel');
  final removeChannel = ActionDispatcher<ChannelModel>('ChannelActions-removeChannel');
  final updateChannel = ActionDispatcher<ChannelModel>('ChannelActions-updateChannel');
  final changeConnectStatus =
      ActionDispatcher<Pair<ChannelModel, ServerConnectStatus>>('ChannelActions-changeConnectStatus');
  final setCurrentChannel = ActionDispatcher<ChannelModel>('ChannelActions-setCurrentChannel');
  final toggleShowFavorites = ActionDispatcher<ChannelModel>('ChannelActions-toggleShowFavorites');
  final toggleShowWhiteList = ActionDispatcher<ChannelModel>('ChannelActions-toggleShowWhiteList');
  final toggleShowBlackList = ActionDispatcher<ChannelModel>('ChannelActions-toggleShowBlackList');
  final toggleAutoScroll = ActionDispatcher<ChannelModel>('ChannelActions-toggleAutoScroll');
  final addWhiteListItem = ActionDispatcher<Pair<ChannelModel, String>>('ChannelActions-addWhiteListItem');
  final addBlackListItem = ActionDispatcher<Pair<ChannelModel, String>>('ChannelActions-addBlackListItem');
  final deleteWhiteListItem = ActionDispatcher<Pair<ChannelModel, String>>('ChannelActions-deleteWhiteListItem');
  final deleteBlackListItem = ActionDispatcher<Pair<ChannelModel, String>>('ChannelActions-deleteBlackListItem');
  final setChannelServerConnectStatus =
      ActionDispatcher<BuiltMap<ChannelModel, ServerConnectStatus>>('ChannelActions-setChannelServerConnectStatus');
  final selectEvent = ActionDispatcher<Pair<ChannelModel, ServerEvent>>('ChannelActions-selectEvent');

  @override
  void setDispatcher(Dispatcher dispatcher) {
    addChannel.setDispatcher(dispatcher);
    addAllChannel.setDispatcher(dispatcher);
    removeChannel.setDispatcher(dispatcher);
    updateChannel.setDispatcher(dispatcher);
    changeConnectStatus.setDispatcher(dispatcher);
    setCurrentChannel.setDispatcher(dispatcher);
    toggleShowFavorites.setDispatcher(dispatcher);
    toggleShowWhiteList.setDispatcher(dispatcher);
    toggleShowBlackList.setDispatcher(dispatcher);
    toggleAutoScroll.setDispatcher(dispatcher);
    addWhiteListItem.setDispatcher(dispatcher);
    addBlackListItem.setDispatcher(dispatcher);
    deleteWhiteListItem.setDispatcher(dispatcher);
    deleteBlackListItem.setDispatcher(dispatcher);
    setChannelServerConnectStatus.setDispatcher(dispatcher);
    selectEvent.setDispatcher(dispatcher);
  }
}

class ChannelActionsNames {
  static final addChannel = ActionName<ChannelModel>('ChannelActions-addChannel');
  static final addAllChannel = ActionName<Iterable<ChannelModel>>('ChannelActions-addAllChannel');
  static final removeChannel = ActionName<ChannelModel>('ChannelActions-removeChannel');
  static final updateChannel = ActionName<ChannelModel>('ChannelActions-updateChannel');
  static final changeConnectStatus =
      ActionName<Pair<ChannelModel, ServerConnectStatus>>('ChannelActions-changeConnectStatus');
  static final setCurrentChannel = ActionName<ChannelModel>('ChannelActions-setCurrentChannel');
  static final toggleShowFavorites = ActionName<ChannelModel>('ChannelActions-toggleShowFavorites');
  static final toggleShowWhiteList = ActionName<ChannelModel>('ChannelActions-toggleShowWhiteList');
  static final toggleShowBlackList = ActionName<ChannelModel>('ChannelActions-toggleShowBlackList');
  static final toggleAutoScroll = ActionName<ChannelModel>('ChannelActions-toggleAutoScroll');
  static final addWhiteListItem = ActionName<Pair<ChannelModel, String>>('ChannelActions-addWhiteListItem');
  static final addBlackListItem = ActionName<Pair<ChannelModel, String>>('ChannelActions-addBlackListItem');
  static final deleteWhiteListItem = ActionName<Pair<ChannelModel, String>>('ChannelActions-deleteWhiteListItem');
  static final deleteBlackListItem = ActionName<Pair<ChannelModel, String>>('ChannelActions-deleteBlackListItem');
  static final setChannelServerConnectStatus =
      ActionName<BuiltMap<ChannelModel, ServerConnectStatus>>('ChannelActions-setChannelServerConnectStatus');
  static final selectEvent = ActionName<Pair<ChannelModel, ServerEvent>>('ChannelActions-selectEvent');
}
