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
  final setServiceInProgress = ActionDispatcher<BuiltMap<ChannelModel, bool>>('ChannelActions-setServiceInProgress');
  final setChannelConnected =
      ActionDispatcher<BuiltMap<ChannelModel, ServerConnectStatus>>('ChannelActions-setChannelConnected');

  @override
  void setDispatcher(Dispatcher dispatcher) {
    addChannel.setDispatcher(dispatcher);
    removeChannel.setDispatcher(dispatcher);
    updateChannel.setDispatcher(dispatcher);
    setServiceInProgress.setDispatcher(dispatcher);
    setChannelConnected.setDispatcher(dispatcher);
  }
}

class ChannelActionsNames {
  static final addChannel = ActionName<ChannelModel>('ChannelActions-addChannel');
  static final removeChannel = ActionName<ChannelModel>('ChannelActions-removeChannel');
  static final updateChannel = ActionName<ChannelModel>('ChannelActions-updateChannel');
  static final setServiceInProgress = ActionName<BuiltMap<ChannelModel, bool>>('ChannelActions-setServiceInProgress');
  static final setChannelConnected =
      ActionName<BuiltMap<ChannelModel, ServerConnectStatus>>('ChannelActions-setChannelConnected');
}
