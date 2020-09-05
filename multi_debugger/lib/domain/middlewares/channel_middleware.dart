import 'package:built_redux/built_redux.dart';
import 'package:multi_debugger/domain/actions/actions.dart';
import 'package:multi_debugger/domain/actions/channel_actions.dart';
import 'package:multi_debugger/domain/models/channel_model.dart';
import 'package:multi_debugger/domain/states/states.dart';

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

void _setCurrentChannel(
  MiddlewareApi<AppState, AppStateBuilder, AppActions> api,
  ActionHandler next,
  Action<ChannelModel> action,
) {
  next(action);

  print('middleware _setCurrentChannel');
  // remote epic
}
