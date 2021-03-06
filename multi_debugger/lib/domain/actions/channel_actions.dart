import 'package:built_collection/built_collection.dart';
import 'package:built_redux/built_redux.dart';
import 'package:multi_debugger/domain/base/pair.dart';
import 'package:multi_debugger/domain/models/models.dart';

part 'channel_actions.g.dart';

abstract class ChannelActions extends ReduxActions {
  ChannelActions._();

  factory ChannelActions() = _$ChannelActions;

  ActionDispatcher<ChannelModel> get addChannel;

  ActionDispatcher<Iterable<ChannelModel>> get addAllChannel;

  ActionDispatcher<String> get removeChannelById;

  ActionDispatcher<String> get removeChannelByName;

  ActionDispatcher<ChannelModel> get updateChannel;

  ActionDispatcher<Pair<ChannelModel, ServerConnectStatus>> get changeConnectStatus;

  ActionDispatcher<ChannelModel> get setCurrentChannel;

  // actions
  ActionDispatcher<ChannelModel> get toggleShowFavorites;

  ActionDispatcher<ChannelModel> get toggleShowWhiteList;

  ActionDispatcher<ChannelModel> get toggleShowBlackList;

  ActionDispatcher<ChannelModel> get toggleAutoScroll;

  // filters
  ActionDispatcher<Pair<ChannelModel, String>> get addWhiteListItem;

  ActionDispatcher<Pair<ChannelModel, String>> get addBlackListItem;

  ActionDispatcher<Pair<ChannelModel, String>> get deleteWhiteListItem;

  ActionDispatcher<Pair<ChannelModel, String>> get deleteBlackListItem;

  ActionDispatcher<BuiltMap<ChannelModel, ServerConnectStatus>> get setChannelServerConnectStatus;

  /// selected server event
  ActionDispatcher<Pair<ChannelModel, ServerEvent>> get selectEvent;
}
