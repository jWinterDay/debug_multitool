import 'package:built_collection/built_collection.dart';
import 'package:built_redux/built_redux.dart';
import 'package:multi_debugger/domain/actions/server_event_actions.dart';
import 'package:multi_debugger/domain/base/pair.dart';
import 'package:multi_debugger/domain/enums/server_event_type.dart';
import 'package:multi_debugger/domain/models/models.dart';
import 'package:multi_debugger/domain/states/server_event_state.dart';
import 'package:multi_debugger/domain/states/states.dart';

NestedReducerBuilder<AppState, AppStateBuilder, ServerEventState, ServerEventStateBuilder>
    createServerEventStateReducer() {
  return NestedReducerBuilder<AppState, AppStateBuilder, ServerEventState, ServerEventStateBuilder>(
      (state) => state.serverEventState, (builder) => builder.serverEventState)
    ..add<Pair<String, ServerEvent>>(ServerEventActionsNames.addEvent, _addEvent)
    ..add<String>(ServerEventActionsNames.clearEventsByChannelId, _clearEvents)
    ..add<Pair<String, ServerEvent>>(ServerEventActionsNames.toggleFavorite, _toggleFavorite);
}

void _addEvent(ServerEventState state, Action<Pair<String, ServerEvent>> action, ServerEventStateBuilder builder) {
  final Pair<String, ServerEvent> serverEventPair = action.payload;

  final String channelId = serverEventPair.first;
  final ServerEvent serverEvent = serverEventPair.second;

  builder.channelIdForLastEvent = channelId;

  builder.events.updateValue(
    channelId,
    (BuiltList<ServerEvent> update) {
      final int len = update.length;
      // check prev and current events are delimiters
      final ServerEvent prevServerEvent = state.getPrevServerEvent(len, channelId);
      final bool isDelimiter = serverEvent.serverEventType == ServerEventType.delimiter;
      final bool isPrevDelimiter = prevServerEvent?.serverEventType == ServerEventType.delimiter;

      if (isDelimiter && isPrevDelimiter) {
        return update;
      }

      return update.rebuild((ListBuilder b) {
        b.add(serverEvent.rebuild((seb) => seb.index = len));
      });
    },
    ifAbsent: () {
      return BuiltList<ServerEvent>.from(<ServerEvent>[serverEvent]);
    },
  );
}

// clear all events in channel model
void _clearEvents(ServerEventState state, Action<String> action, ServerEventStateBuilder builder) {
  final String channelId = action.payload;

  // events
  builder.events.updateValue(
    channelId,
    (BuiltList<ServerEvent> update) {
      return update.rebuild((ListBuilder b) {
        b.clear();
      });
    },
    ifAbsent: () {
      return BuiltList<ServerEvent>();
    },
  );
}

void _toggleFavorite(
  ServerEventState state,
  Action<Pair<String, ServerEvent>> action,
  ServerEventStateBuilder builder,
) {
  final Pair<String, ServerEvent> serverEventPair = action.payload;

  final String channelId = serverEventPair.first;
  final ServerEvent serverEvent = serverEventPair.second;

  builder.events.updateValue(
    channelId,
    (BuiltList<ServerEvent> updates) {
      final int indexInList = updates.indexWhere((ServerEvent se) => se == serverEvent);

      return updates.rebuild((ListBuilder<ServerEvent> b) {
        b[indexInList] = ServerEvent((ServerEventBuilder seb) {
          seb
            ..replace(serverEvent)
            ..favorite = !seb.favorite;

          return seb;
        });

        return b;
      });
    },
    ifAbsent: () {
      return BuiltList<ServerEvent>.from(<ServerEvent>[serverEvent]);
    },
  );
}
