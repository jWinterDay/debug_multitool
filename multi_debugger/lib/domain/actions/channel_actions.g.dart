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
  final removeChannel = ActionDispatcher<ChannelModel>('ChannelActions-removeChannel');
  final updateChannel = ActionDispatcher<ChannelModel>('ChannelActions-updateChannel');
  final changeConnectStatus = ActionDispatcher<ChannelModel>('ChannelActions-changeConnectStatus');
  final setCurrentChannel = ActionDispatcher<ChannelModel>('ChannelActions-setCurrentChannel');
  final setChannelServerConnectStatus =
      ActionDispatcher<BuiltMap<ChannelModel, ServerConnectStatus>>('ChannelActions-setChannelServerConnectStatus');

  @override
  void setDispatcher(Dispatcher dispatcher) {
    addChannel.setDispatcher(dispatcher);
    removeChannel.setDispatcher(dispatcher);
    updateChannel.setDispatcher(dispatcher);
    changeConnectStatus.setDispatcher(dispatcher);
    setCurrentChannel.setDispatcher(dispatcher);
    setChannelServerConnectStatus.setDispatcher(dispatcher);
  }
}

class ChannelActionsNames {
  static final addChannel = ActionName<ChannelModel>('ChannelActions-addChannel');
  static final removeChannel = ActionName<ChannelModel>('ChannelActions-removeChannel');
  static final updateChannel = ActionName<ChannelModel>('ChannelActions-updateChannel');
  static final changeConnectStatus = ActionName<ChannelModel>('ChannelActions-changeConnectStatus');
  static final setCurrentChannel = ActionName<ChannelModel>('ChannelActions-setCurrentChannel');
  static final setChannelServerConnectStatus =
      ActionName<BuiltMap<ChannelModel, ServerConnectStatus>>('ChannelActions-setChannelServerConnectStatus');
}
