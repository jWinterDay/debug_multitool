import 'package:built_redux/built_redux.dart';
import 'package:multi_debugger/domain/actions/platform_event_actions.dart';
import 'package:multi_debugger/domain/models/platform_event.dart';
import 'package:multi_debugger/domain/states/platform_event_state.dart';
import 'package:multi_debugger/domain/states/states.dart';

NestedReducerBuilder<AppState, AppStateBuilder, PlatformEventState, PlatformEventStateBuilder>
    createPlatformEventReducer() {
  return NestedReducerBuilder<AppState, AppStateBuilder, PlatformEventState, PlatformEventStateBuilder>(
    (state) => state.platformEventState,
    (builder) => builder.platformEventState,
  )..add<PlatformEvent>(PlatformEventActionsNames.addEvent, _addEvent);
}

void _addEvent(PlatformEventState state, Action<PlatformEvent> action, PlatformEventStateBuilder builder) {
  PlatformEvent platformEvent = action.payload;

  builder.platformEvent.replace(platformEvent);
}
