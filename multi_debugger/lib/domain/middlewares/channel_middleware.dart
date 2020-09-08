import 'package:built_redux/built_redux.dart';
import 'package:multi_debugger/di/app_di.dart';
import 'package:multi_debugger/domain/actions/actions.dart';
import 'package:multi_debugger/domain/actions/channel_actions.dart';
import 'package:multi_debugger/domain/models/channel_model.dart';
import 'package:multi_debugger/domain/states/states.dart';
import 'package:multi_debugger/services/server_communicate_service/server_communicate_service.dart';

MiddlewareBuilder<AppState, AppStateBuilder, AppActions> createChannelMiddleware() {
  return MiddlewareBuilder<AppState, AppStateBuilder, AppActions>()
    ..add<ChannelModel>(ChannelActionsNames.addChannel, _addChannel)
    ..add<ChannelModel>(ChannelActionsNames.removeChannel, _removeChannel)
    ..add<ChannelModel>(ChannelActionsNames.updateChannel, _updateChannel)
    ..add<ChannelModel>(ChannelActionsNames.setCurrentChannel, _setCurrentChannel);
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

  api.state.serverCommunicateServicesState.services.putIfAbsent(channelModel.name, () {
    return service;
  });
}

void _removeChannel(
  MiddlewareApi<AppState, AppStateBuilder, AppActions> api,
  ActionHandler next,
  Action<ChannelModel> action,
) {
  next(action);

  final ChannelModel channelModel = action.payload;

  // close and remove communicate service
  final ServerCommunicateService service = api.state.serverCommunicateServicesState.services[channelModel.name];
  service.disconnect();
  service.dispose();
  api.state.serverCommunicateServicesState.services.remove(channelModel.name);
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
