// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'saved_url_actions.dart';

// **************************************************************************
// BuiltReduxGenerator
// **************************************************************************

// ignore_for_file: avoid_classes_with_only_static_members
// ignore_for_file: annotate_overrides
// ignore_for_file: overridden_fields
// ignore_for_file: type_annotate_public_apis

class _$SavedUrlActions extends SavedUrlActions {
  factory _$SavedUrlActions() => _$SavedUrlActions._();
  _$SavedUrlActions._() : super._();

  final addUrl = ActionDispatcher<SavedUrl>('SavedUrlActions-addUrl');
  final addAllUrl = ActionDispatcher<Iterable<SavedUrl>>('SavedUrlActions-addAllUrl');
  final deleteUrl = ActionDispatcher<SavedUrl>('SavedUrlActions-deleteUrl');
  final setChannelServerConnectStatus =
      ActionDispatcher<BuiltMap<ChannelModel, ServerConnectStatus>>('SavedUrlActions-setChannelServerConnectStatus');

  @override
  void setDispatcher(Dispatcher dispatcher) {
    addUrl.setDispatcher(dispatcher);
    addAllUrl.setDispatcher(dispatcher);
    deleteUrl.setDispatcher(dispatcher);
    setChannelServerConnectStatus.setDispatcher(dispatcher);
  }
}

class SavedUrlActionsNames {
  static final addUrl = ActionName<SavedUrl>('SavedUrlActions-addUrl');
  static final addAllUrl = ActionName<Iterable<SavedUrl>>('SavedUrlActions-addAllUrl');
  static final deleteUrl = ActionName<SavedUrl>('SavedUrlActions-deleteUrl');
  static final setChannelServerConnectStatus =
      ActionName<BuiltMap<ChannelModel, ServerConnectStatus>>('SavedUrlActions-setChannelServerConnectStatus');
}
