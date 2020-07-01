import 'package:debug_desktop_client/mobx/channel_state.dart';
import 'package:debug_desktop_client/mobx/log_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:debug_desktop_client/tools/uikit.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class ChannelCardScreen extends StatelessWidget {
  const ChannelCardScreen({
    this.logState,
    this.index,
    this.selected,
  });

  final LogState logState;
  final int index;
  final bool selected;

  void _changeWhiteList(ChannelState channelStateStore, {bool inWhiteList}) {
    if (inWhiteList) {
      channelStateStore.currentChannel.removeWhiteListItem(logState.log.action);
      return;
    }

    channelStateStore.currentChannel.addWhiteListItem(logState.log.action);
  }

  void _changeBlackList(ChannelState channelStateStore, {bool inBlackList}) {
    if (inBlackList) {
      channelStateStore.currentChannel.removeBlackListItem(logState.log.action);
      return;
    }

    channelStateStore.currentChannel.addBlackListItem(logState.log.action);
  }

  @override
  Widget build(BuildContext context) {
    final ChannelState channelStateStore = Provider.of<ChannelState>(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 4.0),
      margin: const EdgeInsets.symmetric(horizontal: 2.0, vertical: 2.0),
      decoration: BoxDecoration(
        color: selected ? MyColors.primary : logState.color,
        borderRadius: const BorderRadius.all(Radius.circular(8.0)),
        border: Border.all(
          width: 1.0,
          color: MyColors.gray_666666,
        ),
      ),
      child: Row(
        children: <Widget>[
          if (logState.log.enabled)
            Container(
              padding: const EdgeInsets.only(right: 16.0),
              child: GestureDetector(
                onTap: () {
                  logState.setFavorite();
                },
                child: Observer(
                  builder: (_) {
                    return Icon(
                      logState.isFavorite ? CupertinoIcons.heart_solid : CupertinoIcons.heart,
                      color: MyColors.red,
                    );
                  },
                ),
              ),
            ),
          Expanded(
            child: Text(
              logState.viewedText,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),

          // add to white list
          if (logState.log.enabled)
            Observer(
              builder: (_) {
                final bool inWhiteList = channelStateStore.currentChannel.whiteList.contains(logState.log.action);
                final bool inBlackList = channelStateStore.currentChannel.blackList.contains(logState.log.action);

                return GestureDetector(
                  onTap: inWhiteList ? null : () => _changeWhiteList(channelStateStore, inWhiteList: inWhiteList),
                  child: Container(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Icon(
                      CupertinoIcons.eye_solid,
                      color: inWhiteList ? MyColors.red : MyColors.gray_666666,
                    ),
                  ),
                );
              },
            ),

          // add to black list
          if (logState.log.enabled)
            Observer(builder: (_) {
              final bool inWhiteList = channelStateStore.currentChannel.whiteList.contains(logState.log.action);
              final bool inBlackList = channelStateStore.currentChannel.blackList.contains(logState.log.action);

              return GestureDetector(
                onTap: inBlackList ? null : () => _changeBlackList(channelStateStore, inBlackList: inBlackList),
                child: Icon(
                  CupertinoIcons.minus_circled,
                  color: inBlackList ? MyColors.red : MyColors.gray_666666,
                ),
              );
            }),
        ],
      ),
    );
  }
}
