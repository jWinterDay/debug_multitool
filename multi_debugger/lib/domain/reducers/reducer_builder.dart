import 'package:built_redux/built_redux.dart';
import 'package:multi_debugger/domain/models/app_state.dart';
import 'package:multi_debugger/domain/reducers/channel_reducer.dart';
import 'package:multi_debugger/domain/reducers/config_reducer.dart';

final reducerBuilder = ReducerBuilder<AppState, AppStateBuilder>()
  ..combineNested(createChannelReducer())
  ..combineNested(createConfigReducer());

final reducers = reducerBuilder.build();
