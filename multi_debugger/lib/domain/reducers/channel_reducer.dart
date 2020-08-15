import 'package:built_redux/built_redux.dart';
import 'package:multi_debugger/domain/actions/channel_actions.dart';
import 'package:multi_debugger/domain/models/app_state.dart';

import 'package:multi_debugger/domain/models/channel_state.dart';

NestedReducerBuilder<AppState, AppStateBuilder, ChannelState, ChannelStateBuilder> createChannelReducer() =>
    NestedReducerBuilder<AppState, AppStateBuilder, ChannelState, ChannelStateBuilder>(
      (state) => state.channelState,
      (builder) => builder.channelState,
    )..add<String>(ChannelActionsNames.setName, _setName);

void _setName(ChannelState state, Action<String> action, ChannelStateBuilder builder) => builder..name = action.payload;
