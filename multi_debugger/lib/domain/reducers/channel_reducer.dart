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
      ..add<ChannelModel>(ChannelActionsNames.setCurrentChannel, _setCurrentChannel);

void _addChannel(ChannelState state, Action<ChannelModel> action, ChannelStateBuilder builder) {
  final ChannelModel channelModel = action.payload;

  builder.channels.putIfAbsent(channelModel.channelId, () => channelModel);
}

void _removeChannel(ChannelState state, Action<ChannelModel> action, ChannelStateBuilder builder) {
  final ChannelModel channelModel = action.payload;

  builder.channels.remove(channelModel.channelId);
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

void _setCurrentChannel(ChannelState state, Action<ChannelModel> action, ChannelStateBuilder builder) {
  final ChannelModel channelModel = action.payload;

  builder.channels.updateAllValues((String id, ChannelModel cm) {
    final bool update = channelModel.channelId == cm.channelId;
    return channelModel.rebuild((builder) => builder.isCurrent = update);
  });

  // builder.channels.updateValue(
  //   channelModel.channelId,
  //   (ChannelModel cm) => cm,
  //   ifAbsent: () => channelModel,
  // );
}
