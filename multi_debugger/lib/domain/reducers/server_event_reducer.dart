import 'package:built_collection/built_collection.dart';
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
    ..add<Pair<String, ServerEvent>>(ServerEventActionsNames.addEvent, _addEvent)
    ..add<Pair<String, ServerEvent>>(ServerEventActionsNames.selectEvent, _selectEvent)
    ..add<ChannelModel>(ServerEventActionsNames.clearEvents, _clearEvents)
    ..add<Pair<String, ServerEvent>>(ServerEventActionsNames.toggleFavorite, _toggleFavorite);
}

void _addEvent(ServerEventState state, Action<Pair<String, ServerEvent>> action, ServerEventStateBuilder builder) {
  final Pair<String, ServerEvent> serverEventPair = action.payload;

  final String channelId = serverEventPair.first;
  final ServerEvent serverEvent = serverEventPair.second;

  builder.events.updateValue(
    channelId,
    (BuiltList<ServerEvent> update) {
      return update.rebuild((ListBuilder b) {
        b.add(serverEvent);
      });
    },
    ifAbsent: () {
      return BuiltList<ServerEvent>.from(<ServerEvent>[serverEvent]);
    },
  );
}

void _selectEvent(ServerEventState state, Action<Pair<String, ServerEvent>> action, ServerEventStateBuilder builder) {
  final Pair<String, ServerEvent> serverEventPair = action.payload;

  final String channelId = serverEventPair.first;
  final ServerEvent serverEvent = serverEventPair.second;

  builder.selectedEvents.updateValue(
    channelId,
    (BuiltList<ServerEvent> update) {
      return update.rebuild((ListBuilder b) {
        b.add(serverEvent);
      });
    },
    ifAbsent: () {
      return BuiltList<ServerEvent>.from(<ServerEvent>[serverEvent]);
    },
  );
}

void _clearEvents(ServerEventState state, Action<ChannelModel> action, ServerEventStateBuilder builder) {
  final ChannelModel channelModel = action.payload;

  builder.events.updateValue(
    channelModel.channelId,
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
