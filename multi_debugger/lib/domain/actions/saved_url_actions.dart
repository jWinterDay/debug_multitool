import 'package:built_collection/built_collection.dart';
import 'package:built_redux/built_redux.dart';
import 'package:multi_debugger/domain/models/models.dart';

part 'saved_url_actions.g.dart';

abstract class SavedUrlActions extends ReduxActions {
  SavedUrlActions._();

  factory SavedUrlActions() = _$SavedUrlActions;

  ActionDispatcher<SavedUrl> get addUrl;

  ActionDispatcher<Iterable<SavedUrl>> get addAllUrl;

  ActionDispatcher<SavedUrl> get deleteUrl;

  ActionDispatcher<BuiltMap<ChannelModel, ServerConnectStatus>> get setChannelServerConnectStatus;
}
