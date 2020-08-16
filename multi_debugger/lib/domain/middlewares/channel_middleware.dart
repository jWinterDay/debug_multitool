import 'package:built_collection/built_collection.dart';
import 'package:built_redux/built_redux.dart';
import 'package:multi_debugger/domain/actions/actions.dart';
import 'package:multi_debugger/domain/actions/channel_actions.dart';
import 'package:multi_debugger/domain/models/channel_model.dart';
import 'package:multi_debugger/domain/models/server_connect_status.dart';
import 'package:multi_debugger/domain/states/states.dart';

MiddlewareBuilder<AppState, AppStateBuilder, AppActions> createChannelMiddleware() {
  return MiddlewareBuilder<AppState, AppStateBuilder, AppActions>()
    ..add<ChannelModel>(ChannelActionsNames.addChannel, _addChannel)
    ..add<ChannelModel>(ChannelActionsNames.removeChannel, _removeChannel)
    ..add<ChannelModel>(ChannelActionsNames.updateChannel, _updateChannel)
    ..add<BuiltMap<ChannelModel, ServerConnectStatus>>(ChannelActionsNames.setChannelConnected, _setChannelConnected)
    ..add<BuiltMap<ChannelModel, bool>>(ChannelActionsNames.setServiceInProgress, _setServiceInProgress);
}

void _addChannel(
  MiddlewareApi<AppState, AppStateBuilder, AppActions> api,
  ActionHandler next,
  Action<ChannelModel> action,
) {
  next(action);

  print('middleware _addChannel');
  // remote epic
}

void _removeChannel(
  MiddlewareApi<AppState, AppStateBuilder, AppActions> api,
  ActionHandler next,
  Action<ChannelModel> action,
) {
  next(action);

  print('middleware _removeChannel');
  // remote epic
}

void _updateChannel(
  MiddlewareApi<AppState, AppStateBuilder, AppActions> api,
  ActionHandler next,
  Action<ChannelModel> action,
) {
  next(action);

  print('middleware _updateChannel');
  // remote epic
}

void _setChannelConnected(
  MiddlewareApi<AppState, AppStateBuilder, AppActions> api,
  ActionHandler next,
  Action<BuiltMap<ChannelModel, ServerConnectStatus>> action,
) {
  next(action);
  // remote epic
}

void _setServiceInProgress(
  MiddlewareApi<AppState, AppStateBuilder, AppActions> api,
  ActionHandler next,
  Action<BuiltMap<ChannelModel, bool>> action,
) {
  next(action);
  // remote epic
}
