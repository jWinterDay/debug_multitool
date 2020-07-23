import 'package:debug_desktop_client/mobx/channel_state.dart';
import 'package:debug_desktop_client/mobx/log_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:debug_desktop_client/tools/uikit.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class ChannelCardScreen extends StatelessWidget {
  const ChannelCardScreen({
    @required this.logState,
    @required this.index,
    @required this.selected,
    @required this.callback,
  });

  final LogState logState;
  final int index;
  final bool selected;
  final VoidCallback callback;

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

  Widget _actionIcon({
    bool actionEnable = false,
    bool val = false,
    VoidCallback iconCallback,
    IconData iconData,
  }) {
    return GestureDetector(
      onTap: () {
        if (actionEnable) {
          iconCallback();
        }
      },
      child: Container(
        padding: const EdgeInsets.only(right: 8.0),
        child: Icon(
          iconData,
          color: val ? MyColors.red : MyColors.gray_666666,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ChannelState channelStateStore = Provider.of<ChannelState>(context);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 2.0, vertical: 2.0),
      // padding: const EdgeInsets.symmetric(horizontal: 2.0, vertical: 2.0),
      decoration: BoxDecoration(
        color: selected ? MyColors.primary.withOpacity(0.3) : logState.color,
        borderRadius: const BorderRadius.all(Radius.circular(8.0)),
        border: Border.all(
          width: 1.0,
          color: MyColors.gray_666666,
        ),
      ),
      child: Row(
        children: <Widget>[
          // favorite
          if (logState.log.enabled)
            Container(
              color: MyColors.transparent,
              padding: const EdgeInsets.only(right: 4.0),
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

          // send back
          if (logState.log.canSend)
            Container(
              color: MyColors.transparent,
              padding: const EdgeInsets.only(right: 4.0),
              child: GestureDetector(
                onTap: () {
                  channelStateStore.currentChannel.sendLogStateBack(logState);
                },
                child: const Icon(
                  CupertinoIcons.reply_all,
                  color: MyColors.red,
                ),
              ),
            ),

          // content
          Expanded(
            child: GestureDetector(
              onTap: callback == null ? null : () => callback(),
              child: Container(
                color: MyColors.transparent,
                // height: 25.0,
                padding: const EdgeInsets.only(left: 4.0, top: 4.0),
                child: Text(
                  logState.viewedText,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.start,
                ),
              ),
            ),
          ),

          // add to white list
          if (logState.log.enabled)
            Observer(
              builder: (_) {
                final bool inWhiteList = channelStateStore.currentChannel.whiteList.contains(logState.log.action);
                final bool inBlackList = channelStateStore.currentChannel.blackList.contains(logState.log.action);

                return _actionIcon(
                  actionEnable: !inBlackList,
                  val: inWhiteList,
                  iconData: CupertinoIcons.eye_solid,
                  iconCallback: () => _changeWhiteList(channelStateStore, inWhiteList: inWhiteList),
                );
              },
            ),

          // add to black list
          if (logState.log.enabled)
            Observer(builder: (_) {
              final bool inWhiteList = channelStateStore.currentChannel.whiteList.contains(logState.log.action);
              final bool inBlackList = channelStateStore.currentChannel.blackList.contains(logState.log.action);

              return _actionIcon(
                actionEnable: !inWhiteList,
                val: inBlackList,
                iconData: CupertinoIcons.clear_thick,
                iconCallback: () => _changeBlackList(channelStateStore, inBlackList: inBlackList),
              );
            }),
        ],
      ),
    );
  }
}
