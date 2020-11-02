import 'package:built_redux/built_redux.dart';
import 'package:multi_debugger/domain/actions/actions.dart';
import 'package:multi_debugger/domain/actions/server_event_actions.dart';
import 'package:multi_debugger/domain/models/channel_model.dart';
import 'package:multi_debugger/domain/states/states.dart';

MiddlewareBuilder<AppState, AppStateBuilder, AppActions> createServerEventMiddleware() {
  return MiddlewareBuilder<AppState, AppStateBuilder, AppActions>()
    ..add<String>(ServerEventActionsNames.clearEventsByChannelId, _clearEventsByChannelId)
    ..add<String>(ServerEventActionsNames.clearEventsByChannelName, _clearEventsByChannelName);
}

void _clearEventsByChannelId(
  MiddlewareApi<AppState, AppStateBuilder, AppActions> api,
  ActionHandler next,
  Action<String> action,
) {
  next(action);

  String channelId = action.payload;

  ChannelModel channelModel = api.state.channelState.channels[channelId];

  if (channelModel == null) {
    return;
  }

  final ChannelModel nextChannelModel = ChannelModel((b) {
    b
      ..replace(channelModel)
      ..selectedEvent = null;
    return b;
  });

  api.actions.channelActions.updateChannel(nextChannelModel);
}

void _clearEventsByChannelName(
  MiddlewareApi<AppState, AppStateBuilder, AppActions> api,
  ActionHandler next,
  Action<String> action,
) {
  next(action);

  String channelName = action.payload;

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

  String channelId = channelModel.channelId;

  final ChannelModel nextChannelModel = ChannelModel((b) {
    b
      ..replace(channelModel)
      ..selectedEvent = null;
    return b;
  });

  api.actions.channelActions.updateChannel(nextChannelModel);
}
