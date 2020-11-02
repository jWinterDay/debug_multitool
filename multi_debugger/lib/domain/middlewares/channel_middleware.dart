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
    ..add<String>(ChannelActionsNames.removeChannelById, _removeChannelById)
    ..add<String>(ChannelActionsNames.removeChannelByName, _removeChannelByName)
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

  if (channelModel.autoConnect) {
    Pair<ChannelModel, ServerConnectStatus> pair = Pair(channelModel, ServerConnectStatus.connecting);

    api.actions.channelActions.changeConnectStatus(pair);
  }
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

void _removeChannelById(
  MiddlewareApi<AppState, AppStateBuilder, AppActions> api,
  ActionHandler next,
  Action<String> action,
) {
  final String channelId = action.payload;

  // close and remove communicate service
  ServerCommunicateService service = api.state.serverCommunicateServicesState.services[channelId];

  if (service != null) {
    service
      ..disconnect()
      ..dispose();

    api.state.serverCommunicateServicesState.services.remove(channelId);
  }

  // clear logs
  api.actions.serverEventActions.clearEventsByChannelId(channelId);

  next(action);
}

void _removeChannelByName(
  MiddlewareApi<AppState, AppStateBuilder, AppActions> api,
  ActionHandler next,
  Action<String> action,
) {
  final String channelName = action.payload;

  // find channel
  ChannelModel channelModel = api.state.channelState.channels.values.firstWhere(
    (ChannelModel cm) {
      return cm.name == channelName;
    },
    orElse: () => null,
  );

  if (channelModel == null) {
    return;
  }

  final String channelId = channelModel.channelId;

  // close and remove communicate service
  ServerCommunicateService service = api.state.serverCommunicateServicesState.services[channelId];

  if (service != null) {
    service
      ..disconnect()
      ..dispose();

    api.state.serverCommunicateServicesState.services.remove(channelId);
  }

  // clear logs
  api.actions.serverEventActions.clearEventsByChannelName(channelName);

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
    final SavedUrl savedUrl = SavedUrl(
      (b) => b
        ..url = channelModel.wsUrl
        ..custom = true,
    );

    api.actions.savedUrlActions.addUrl(savedUrl);
  }
}
