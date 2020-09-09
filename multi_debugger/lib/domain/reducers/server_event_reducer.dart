import 'package:built_redux/built_redux.dart';
import 'package:multi_debugger/domain/actions/server_event_actions.dart';
import 'package:multi_debugger/domain/base/pair.dart';
import 'package:multi_debugger/domain/models/models.dart';
import 'package:multi_debugger/domain/states/server_event_state.dart';
import 'package:multi_debugger/domain/states/states.dart';

NestedReducerBuilder<AppState, AppStateBuilder, ServerEventState, ServerEventStateBuilder>
    createServerEventStateReducer() {
  return NestedReducerBuilder<AppState, AppStateBuilder, ServerEventState, ServerEventStateBuilder>(
      (state) => state.serverEventState, (builder) => builder.serverEventState)
    ..add<Pair<String, ServerEvent>>(ServerEventActionsNames.addEvent, _addEvent);
}

void _addEvent(ServerEventState state, Action<Pair<String, ServerEvent>> action, ServerEventStateBuilder builder) {
  final Pair<String, ServerEvent> serverEventPair = action.payload;

  final String channelName = serverEventPair.first;
  final ServerEvent serverEvent = serverEventPair.second;

  builder.events.updateValue(
    channelName,
    (List<ServerEvent> update) {
      update.add(serverEvent);

      return update;
    },
    ifAbsent: () {
      return [serverEvent];
    },
  );
}
