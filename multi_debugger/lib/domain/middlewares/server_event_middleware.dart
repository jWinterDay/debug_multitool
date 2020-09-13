import 'package:built_redux/built_redux.dart';
import 'package:multi_debugger/domain/actions/actions.dart';
import 'package:multi_debugger/domain/actions/server_event_actions.dart';
import 'package:multi_debugger/domain/models/channel_model.dart';
import 'package:multi_debugger/domain/states/states.dart';

MiddlewareBuilder<AppState, AppStateBuilder, AppActions> createServerEventMiddleware() {
  return MiddlewareBuilder<AppState, AppStateBuilder, AppActions>()
    ..add<ChannelModel>(ServerEventActionsNames.clearEvents, _clearEvents);
}

void _clearEvents(
  MiddlewareApi<AppState, AppStateBuilder, AppActions> api,
  ActionHandler next,
  Action<ChannelModel> action,
) {
  next(action);

  ChannelModel channelModel = action.payload;

  final ChannelModel nextChannelModel = ChannelModel((b) {
    b
      ..replace(channelModel)
      ..selectedEvent = null;
    return b;
  });

  api.actions.channelActions.updateChannel(nextChannelModel);
}
