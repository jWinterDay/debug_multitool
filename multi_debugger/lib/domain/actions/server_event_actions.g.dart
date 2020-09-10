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
  final toggleFavorite = ActionDispatcher<Pair<String, ServerEvent>>('ServerEventActions-toggleFavorite');

  @override
  void setDispatcher(Dispatcher dispatcher) {
    addEvent.setDispatcher(dispatcher);
    toggleFavorite.setDispatcher(dispatcher);
  }
}

class ServerEventActionsNames {
  static final addEvent = ActionName<Pair<String, ServerEvent>>('ServerEventActions-addEvent');
  static final toggleFavorite = ActionName<Pair<String, ServerEvent>>('ServerEventActions-toggleFavorite');
}
