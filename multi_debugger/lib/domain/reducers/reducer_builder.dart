import 'package:built_redux/built_redux.dart';
import 'package:multi_debugger/domain/reducers/channel_reducer.dart';
import 'package:multi_debugger/domain/reducers/config_reducer.dart';
import 'package:multi_debugger/domain/reducers/select_url_reducer.dart';
import 'package:multi_debugger/domain/reducers/server_event_reducer.dart';
import 'package:multi_debugger/domain/states/states.dart';

final reducerBuilder = ReducerBuilder<AppState, AppStateBuilder>()
  ..combineNested(createChannelReducer())
  ..combineNested(createConfigReducer())
  ..combineNested(createServerEventStateReducer())
  ..combineNested(createSelectUrlReducer());

final reducers = reducerBuilder.build();
