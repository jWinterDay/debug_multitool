import 'package:built_redux/built_redux.dart';
import 'package:multi_debugger/di/app_di.dart';
import 'package:multi_debugger/domain/actions/actions.dart';
import 'package:multi_debugger/domain/actions/channel_actions.dart';
import 'package:multi_debugger/domain/base/pair.dart';
import 'package:multi_debugger/domain/models/channel_model.dart';
import 'package:multi_debugger/domain/models/saved_url.dart';
import 'package:multi_debugger/domain/models/server_connect_status.dart';
import 'package:multi_debugger/domain/states/states.dart';
import 'package:multi_debugger/services/server_communicate_service/server_communicate_service.dart';

MiddlewareBuilder<AppState, AppStateBuilder, AppActions> createChannelMiddleware() {
  return MiddlewareBuilder<AppState, AppStateBuilder, AppActions>()
    ..add<ChannelModel>(ChannelActionsNames.addChannel, _addChannel)
    ..add<Iterable<ChannelModel>>(ChannelActionsNames.addAllChannel, _addAllChannel)
    ..add<ChannelModel>(ChannelActionsNames.removeChannel, _removeChannel)
    ..add<ChannelModel>(ChannelActionsNames.updateChannel, _updateChannel)
    ..add<ChannelModel>(ChannelActionsNames.setCurrentChannel, _setCurrentChannel)
    ..add<Pair<ChannelModel, ServerConnectStatus>>(ChannelActionsNames.changeConnectStatus, _changeConnectStatus);
}

void _addChannel(
  MiddlewareApi<AppState, AppStateBuilder, AppActions> api,
  ActionHandler next,
  Action<ChannelModel> action,
) {
  next(action);

  final ChannelModel channelModel = action.payload;

  // create and add communicate service
  final ServerCommunicateService service = di.get<ServerCommunicateService>();

  api.state.serverCommunicateServicesState.services.putIfAbsent(channelModel.channelId, () {
    return service;
  });
}

void _addAllChannel(
  MiddlewareApi<AppState, AppStateBuilder, AppActions> api,
  ActionHandler next,
  Action<Iterable<ChannelModel>> action,
) {
  next(action);

  final Iterable<ChannelModel> channelModelList = action.payload;

  final Map<String, ServerCommunicateService> channelModelListAsMap = {
    for (ChannelModel channelModel in channelModelList) (channelModel).channelId: di.get<ServerCommunicateService>(),
  };

  api.state.serverCommunicateServicesState.services.addAll(channelModelListAsMap);
}

void _removeChannel(
  MiddlewareApi<AppState, AppStateBuilder, AppActions> api,
  ActionHandler next,
  Action<ChannelModel> action,
) {
  final ChannelModel channelModel = action.payload;

  // close and remove communicate service
  api.state.serverCommunicateServicesState.services[channelModel.channelId]
    ..disconnect()
    ..dispose();
  api.state.serverCommunicateServicesState.services.remove(channelModel.channelId);

  // clear logs
  api.actions.serverEventActions.clearEvents(channelModel);

  next(action);
}

void _updateChannel(
  MiddlewareApi<AppState, AppStateBuilder, AppActions> api,
  ActionHandler next,
  Action<ChannelModel> action,
) {
  next(action);
}

void _setCurrentChannel(
  MiddlewareApi<AppState, AppStateBuilder, AppActions> api,
  ActionHandler next,
  Action<ChannelModel> action,
) {
  next(action);
}

void _changeConnectStatus(
  MiddlewareApi<AppState, AppStateBuilder, AppActions> api,
  ActionHandler next,
  Action<Pair<ChannelModel, ServerConnectStatus>> action,
) {
  next(action);

  Pair<ChannelModel, ServerConnectStatus> pair = action.payload;

  final ChannelModel channelModel = pair.first;
  final ServerConnectStatus status = pair.second;

  // add url to list
  if (status == ServerConnectStatus.connecting) {
    final SavedUrl savedUrl = SavedUrl((b) => b
      ..url = channelModel.wsUrl
      ..custom = true);

    api.actions.savedUrlActions.addUrl(savedUrl);
  }
}
