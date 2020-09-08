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
      ..add<ChannelModel>(ChannelActionsNames.changeConnectStatus, _changeConnectStatus)
      ..add<ChannelModel>(ChannelActionsNames.setCurrentChannel, _setCurrentChannel);

void _addChannel(ChannelState state, Action<ChannelModel> action, ChannelStateBuilder builder) {
  final ChannelModel channelModel = action.payload;

  // set other channel not current
  builder.channels.updateAllValues((String id, ChannelModel cm) {
    return cm.rebuild((builder) => builder.isCurrent = false);
  });

  // channel list
  builder.channels.putIfAbsent(channelModel.channelId, () => channelModel);

  // service list
  // final ServerCommunicateService service = di.get<ServerCommunicateService>();
  // state.serverCommunicateServices.rebuild(() => null) putIfAbsent(channelModel.channelId, () => service);
}

void _removeChannel(ChannelState state, Action<ChannelModel> action, ChannelStateBuilder builder) {
  final ChannelModel channelModel = action.payload;

  // channel list
  builder.channels.remove(channelModel.channelId);

  // service list
  // final ServerCommunicateService service =
  //     builder.serverCommunicateServices[channelModel.channelId] as ServerCommunicateService;
  // service.disconnect();
  // service.dispose();
  // builder.serverCommunicateServices.remove(channelModel.channelId);
}

void _updateChannel(ChannelState state, Action<ChannelModel> action, ChannelStateBuilder builder) {
  final ChannelModel channelModel = action.payload;

  builder.channels.updateValue(
    channelModel.channelId,
    (ChannelModel _) {
      return channelModel;
    },
    ifAbsent: () {
      return channelModel;
    },
  );
}

void _changeConnectStatus(ChannelState state, Action<ChannelModel> action, ChannelStateBuilder builder) {
  _updateChannel(state, action, builder);
}

void _setCurrentChannel(ChannelState state, Action<ChannelModel> action, ChannelStateBuilder builder) {
  final ChannelModel channelModel = action.payload;

  builder.channels.updateAllValues((String id, ChannelModel cm) {
    final bool update = channelModel.channelId == cm.channelId;

    return cm.rebuild((builder) => builder.isCurrent = update);
  });
}
