// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'server_event_actions.dart';

// **************************************************************************
// BuiltReduxGenerator
// **************************************************************************

// ignore_for_file: avoid_classes_with_only_static_members
// ignore_for_file: annotate_overrides
// ignore_for_file: overridden_fields
// ignore_for_file: type_annotate_public_apis

class _$ServerEventActions extends ServerEventActions {
  factory _$ServerEventActions() => _$ServerEventActions._();
  _$ServerEventActions._() : super._();

  final addEvent = ActionDispatcher<Pair<String, ServerEvent>>('ServerEventActions-addEvent');
  final clearEventsByChannelId = ActionDispatcher<String>('ServerEventActions-clearEventsByChannelId');
  final clearEventsByChannelName = ActionDispatcher<String>('ServerEventActions-clearEventsByChannelName');
  final toggleFavorite = ActionDispatcher<Pair<String, ServerEvent>>('ServerEventActions-toggleFavorite');

  @override
  void setDispatcher(Dispatcher dispatcher) {
    addEvent.setDispatcher(dispatcher);
    clearEventsByChannelId.setDispatcher(dispatcher);
    clearEventsByChannelName.setDispatcher(dispatcher);
    toggleFavorite.setDispatcher(dispatcher);
  }
}

class ServerEventActionsNames {
  static final addEvent = ActionName<Pair<String, ServerEvent>>('ServerEventActions-addEvent');
  static final clearEventsByChannelId = ActionName<String>('ServerEventActions-clearEventsByChannelId');
  static final clearEventsByChannelName = ActionName<String>('ServerEventActions-clearEventsByChannelName');
  static final toggleFavorite = ActionName<Pair<String, ServerEvent>>('ServerEventActions-toggleFavorite');
}
