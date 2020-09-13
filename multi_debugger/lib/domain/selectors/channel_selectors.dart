import 'package:multi_debugger/domain/actions/channel_actions.dart';

class ChannelSelectors {
  /// actions to save local channel state
  static List<String> actionNames = [
    // ChannelActionsNames.addAllChannel.name,
    ChannelActionsNames.addBlackListItem.name,
    ChannelActionsNames.addChannel.name,
    ChannelActionsNames.addWhiteListItem.name,
    ChannelActionsNames.deleteBlackListItem.name,
    ChannelActionsNames.deleteWhiteListItem.name,
    ChannelActionsNames.removeChannel.name,
    ChannelActionsNames.toggleAutoScroll.name,
    ChannelActionsNames.toggleShowWhiteList.name,
    ChannelActionsNames.toggleShowBlackList.name,
    ChannelActionsNames.toggleShowFavorites.name,
    ChannelActionsNames.updateChannel.name,
  ];
}
