import 'package:built_collection/built_collection.dart';
import 'package:built_redux/built_redux.dart';
import 'package:multi_debugger/domain/models/models.dart';

part 'channel_actions.g.dart';

abstract class ChannelActions extends ReduxActions {
  ChannelActions._();

  factory ChannelActions() = _$ChannelActions;

  ActionDispatcher<ChannelModel> get addChannel;

  ActionDispatcher<ChannelModel> get removeChannel;

  ActionDispatcher<ChannelModel> get updateChannel;

  ActionDispatcher<ChannelModel> get setCurrentChannel;

  ActionDispatcher<BuiltMap<ChannelModel, ServerConnectStatus>> get setChannelServerConnectStatus;
}
