// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'actions.dart';

// **************************************************************************
// BuiltReduxGenerator
// **************************************************************************

// ignore_for_file: avoid_classes_with_only_static_members
// ignore_for_file: annotate_overrides
// ignore_for_file: overridden_fields
// ignore_for_file: type_annotate_public_apis

class _$AppActions extends AppActions {
  factory _$AppActions() => _$AppActions._();
  _$AppActions._() : super._();

  final routeTo = ActionDispatcher<AppRoute>('AppActions-routeTo');

  final appConfigActions = AppConfigActions();
  final channelActions = ChannelActions();
  final savedUrlActions = SavedUrlActions();
  final serverEventActions = ServerEventActions();
  final platformEventActions = PlatformEventActions();

  @override
  void setDispatcher(Dispatcher dispatcher) {
    routeTo.setDispatcher(dispatcher);

    appConfigActions.setDispatcher(dispatcher);
    channelActions.setDispatcher(dispatcher);
    savedUrlActions.setDispatcher(dispatcher);
    serverEventActions.setDispatcher(dispatcher);
    platformEventActions.setDispatcher(dispatcher);
  }
}

class AppActionsNames {
  static final routeTo = ActionName<AppRoute>('AppActions-routeTo');
}
