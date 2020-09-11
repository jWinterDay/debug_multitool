import 'package:built_redux/built_redux.dart';
import 'package:multi_debugger/domain/actions/channel_actions.dart';
import 'package:multi_debugger/domain/base/pair.dart';
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
      ..add<ChannelModel>(ChannelActionsNames.setCurrentChannel, _setCurrentChannel)
      ..add<ChannelModel>(ChannelActionsNames.toggleShowFavorites, _toggleShowFavorites)
      ..add<ChannelModel>(ChannelActionsNames.toggleShowWhiteList, _toggleShowWhiteList)
      ..add<ChannelModel>(ChannelActionsNames.toggleShowBlackList, _toggleShowBlackList)
      ..add<ChannelModel>(ChannelActionsNames.toggleAutoScroll, _toggleAutoScroll);

void _addChannel(ChannelState state, Action<ChannelModel> action, ChannelStateBuilder builder) {
  final ChannelModel channelModel = action.payload;

  // set other channel not current
  builder.channels.updateAllValues((String id, ChannelModel cm) {
    return cm.rebuild((builder) => builder.isCurrent = false);
  });

  // channel list
  builder.channels.putIfAbsent(channelModel.channelId, () => channelModel);
}

void _removeChannel(ChannelState state, Action<ChannelModel> action, ChannelStateBuilder builder) {
  final ChannelModel channelModel = action.payload;

  // channel list
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

// TODO remake
void _changeConnectStatus(ChannelState state, Action<ChannelModel> action, ChannelStateBuilder builder) {
  _updateChannel(state, action, builder);
}

void _toggleShowFavorites(ChannelState state, Action<ChannelModel> action, ChannelStateBuilder builder) {
  final ChannelModel channelModel = action.payload;

  final ChannelModel nextChannelModel = channelModel.rebuild((update) {
    return update.showFavoriteOnly = !channelModel.showFavoriteOnly;
  });

  Action<ChannelModel> nextAction = Action<ChannelModel>(
    ChannelActionsNames.toggleShowFavorites.name,
    nextChannelModel,
  );

  _updateChannel(state, nextAction, builder);
}

void _toggleShowWhiteList(ChannelState state, Action<ChannelModel> action, ChannelStateBuilder builder) {
  final ChannelModel channelModel = action.payload;

  final ChannelModel nextChannelModel = channelModel.rebuild((update) {
    return update.isWhiteListUsed = !channelModel.isWhiteListUsed;
  });

  Action<ChannelModel> nextAction = Action<ChannelModel>(
    ChannelActionsNames.toggleShowWhiteList.name,
    nextChannelModel,
  );

  _updateChannel(state, nextAction, builder);
}

void _toggleShowBlackList(ChannelState state, Action<ChannelModel> action, ChannelStateBuilder builder) {
  final ChannelModel channelModel = action.payload;

  final ChannelModel nextChannelModel = channelModel.rebuild((update) {
    return update.isBlackListUsed = !channelModel.isBlackListUsed;
  });

  Action<ChannelModel> nextAction = Action<ChannelModel>(
    ChannelActionsNames.toggleShowBlackList.name,
    nextChannelModel,
  );

  _updateChannel(state, nextAction, builder);
}

void _setCurrentChannel(ChannelState state, Action<ChannelModel> action, ChannelStateBuilder builder) {
  final ChannelModel channelModel = action.payload;

  builder.channels.updateAllValues((String id, ChannelModel cm) {
    final bool update = channelModel.channelId == cm.channelId;

    return cm.rebuild((builder) => builder.isCurrent = update);
  });
}

void _toggleAutoScroll(ChannelState state, Action<ChannelModel> action, ChannelStateBuilder builder) {
  final ChannelModel channelModel = action.payload;

  final ChannelModel nextChannelModel = channelModel.rebuild((update) {
    return update.useAutoScroll = !channelModel.useAutoScroll;
  });

  Action<ChannelModel> nextAction = Action<ChannelModel>(
    ChannelActionsNames.toggleShowBlackList.name,
    nextChannelModel,
  );

  _updateChannel(state, nextAction, builder);
}
