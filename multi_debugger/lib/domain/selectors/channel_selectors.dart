import 'package:multi_debugger/domain/actions/channel_actions.dart';

class ChannelSelectors {
  /// actions to save local channel state
  static List<String> actionNames = [
    //
    ChannelActionsNames.addChannel.name,
    ChannelActionsNames.updateChannel.name,
    ChannelActionsNames.removeChannelById.name,
    ChannelActionsNames.removeChannelByName.name,
    ChannelActionsNames.setCurrentChannel.name,
    //
    ChannelActionsNames.addBlackListItem.name,
    ChannelActionsNames.deleteBlackListItem.name,
    ChannelActionsNames.toggleShowBlackList.name,
    //
    ChannelActionsNames.addWhiteListItem.name,
    ChannelActionsNames.deleteWhiteListItem.name,
    ChannelActionsNames.toggleShowWhiteList.name,
    //
    ChannelActionsNames.toggleAutoScroll.name,
    ChannelActionsNames.toggleShowFavorites.name,
  ];
}
