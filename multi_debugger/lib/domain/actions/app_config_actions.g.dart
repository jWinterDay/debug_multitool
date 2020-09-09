// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_config_actions.dart';

// **************************************************************************
// BuiltReduxGenerator
// **************************************************************************

// ignore_for_file: avoid_classes_with_only_static_members
// ignore_for_file: annotate_overrides
// ignore_for_file: overridden_fields
// ignore_for_file: type_annotate_public_apis

class _$AppConfigActions extends AppConfigActions {
  factory _$AppConfigActions() => _$AppConfigActions._();
  _$AppConfigActions._() : super._();

  final setLocalSettings = ActionDispatcher<LocalSettingsState>('AppConfigActions-setLocalSettings');
  final fetchComputerName = ActionDispatcher<void>('AppConfigActions-fetchComputerName');
  final setComputerName = ActionDispatcher<String>('AppConfigActions-setComputerName');
  final fetchLocalSettings = ActionDispatcher<void>('AppConfigActions-fetchLocalSettings');
  final setSavedUrls = ActionDispatcher<String>('AppConfigActions-setSavedUrls');

  @override
  void setDispatcher(Dispatcher dispatcher) {
    setLocalSettings.setDispatcher(dispatcher);
    fetchComputerName.setDispatcher(dispatcher);
    setComputerName.setDispatcher(dispatcher);
    fetchLocalSettings.setDispatcher(dispatcher);
    setSavedUrls.setDispatcher(dispatcher);
  }
}

class AppConfigActionsNames {
  static final setLocalSettings = ActionName<LocalSettingsState>('AppConfigActions-setLocalSettings');
  static final fetchComputerName = ActionName<void>('AppConfigActions-fetchComputerName');
  static final setComputerName = ActionName<String>('AppConfigActions-setComputerName');
  static final fetchLocalSettings = ActionName<void>('AppConfigActions-fetchLocalSettings');
  static final setSavedUrls = ActionName<String>('AppConfigActions-setSavedUrls');
}
