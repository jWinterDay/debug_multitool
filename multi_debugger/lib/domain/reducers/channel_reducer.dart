import 'package:built_collection/built_collection.dart';
import 'package:built_redux/built_redux.dart';
import 'package:multi_debugger/domain/actions/channel_actions.dart';
import 'package:multi_debugger/domain/models/models.dart';
import 'package:multi_debugger/domain/states/app_state.dart';
import 'package:multi_debugger/domain/states/states.dart';

NestedReducerBuilder<AppState, AppStateBuilder, ChannelState, ChannelStateBuilder> createChannelReducer() =>
    NestedReducerBuilder<AppState, AppStateBuilder, ChannelState, ChannelStateBuilder>(
      (state) => state.channelState,
      (builder) => builder.channelState,
    )
      ..add<ChannelModel>(ChannelActionsNames.addChannel, _addChannel)
      ..add<ChannelModel>(ChannelActionsNames.removeChannel, _removeChannel)
      ..add<ChannelModel>(ChannelActionsNames.updateChannel, _updateChannel)
      ..add<BuiltMap<ChannelModel, bool>>(ChannelActionsNames.setServiceInProgress, _setServiceInProgress)
      ..add<BuiltMap<ChannelModel, ServerConnectStatus>>(ChannelActionsNames.setChannelConnected, _setChannelConnected);

void _addChannel(ChannelState state, Action<ChannelModel> action, ChannelStateBuilder builder) {
  final ChannelModel channelModel = action.payload;

  // builder.channelList.add(channelModel);
  // builder.serviceInProgress[channelModel] = false;
}

void _removeChannel(ChannelState state, Action<ChannelModel> action, ChannelStateBuilder builder) {
  final ChannelModel channelModel = action.payload;

  // builder.channelList.removeWhere((ChannelModel val) {
  //   return val == channelModel;
  // });

  // builder.serviceInProgress.remove(channelModel);
}

void _updateChannel(ChannelState state, Action<ChannelModel> action, ChannelStateBuilder builder) {
  final ChannelModel channelModel = action.payload;

  // final BuiltList nextList = builder.channelList.build().map((ChannelModel val) {
  //   if (val == channelModel) {
  //     return channelModel;
  //   }

  //   return val;
  // }).toBuiltList();
}

void _setServiceInProgress(
  ChannelState state,
  Action<BuiltMap<ChannelModel, bool>> action,
  ChannelStateBuilder builder,
) {
  final BuiltMap<ChannelModel, bool> inData = action.payload;

  // inData.forEach((ChannelModel channelModel, bool inProgress) {
  //   builder.serviceInProgress.updateValue(
  //     channelModel,
  //     (bool curVal) => inProgress,
  //     ifAbsent: () => builder.serviceInProgress[channelModel] = inProgress,
  //   );
  // });
}

void _setChannelConnected(
  ChannelState state,
  Action<BuiltMap<ChannelModel, ServerConnectStatus>> action,
  ChannelStateBuilder builder,
) {
  // builder..channelList
}
