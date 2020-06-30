import 'package:debug_desktop_client/app_translations.dart';
import 'package:debug_desktop_client/mobx/app_settings_state.dart';
import 'package:debug_desktop_client/mobx/channel_state.dart';
import 'package:debug_desktop_client/mobx/connect_status.dart';
import 'package:debug_desktop_client/mobx/log.dart';
import 'package:debug_desktop_client/tools/uikit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';

class LogActions extends StatelessWidget {
  const LogActions({
    @required this.channelStateStore,
    @required this.clearCallback,
  }) : assert(channelStateStore != null);

  final ChannelState channelStateStore;
  final VoidCallback clearCallback;

  @override
  Widget build(BuildContext context) {
    final AppSettingsState appSettingsState = Provider.of<AppSettingsState>(context);

    return Container(
      decoration: const BoxDecoration(
        color: MyColors.gray_b3b3b3,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          // follow to the end
          Column(
            children: [
              Observer(builder: (_) {
                return CupertinoSwitch(
                  value: appSettingsState.scrollToEnd,
                  onChanged: (bool val) {
                    appSettingsState.setScrollToEnd(val);
                  },
                );
              }),
              Text(
                appTranslations.text('settings_follow_to_the_end'),
                style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              ),
            ],
          ),

          // clear
          GestureDetector(
            onTap: clearCallback == null ? null : () => clearCallback(),
            child: Container(
              color: MyColors.transparent,
              child: Column(
                children: <Widget>[
                  const Icon(
                    CupertinoIcons.clear_circled,
                    color: MyColors.red,
                    size: 24.0,
                  ),
                  Text(
                    appTranslations.text('common_clear'),
                    style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),

          // add delimiter
          GestureDetector(
            onTap: channelStateStore.currentChannel.connectStatus == ConnectStatus.connecting
                ? null
                : () {
                    final Log log = Log(
                      id: channelStateStore.currentChannel.logs.length,
                      action: '------------------------',
                      actionPayload: '',
                      state: '',
                      enabled: false,
                      prevLog: channelStateStore.currentChannel.logs.isEmpty
                          ? null
                          : channelStateStore.currentChannel.logs.last,
                    );
                    channelStateStore.currentChannel.addLog(log);
                  },
            child: Container(
              color: MyColors.transparent,
              child: Column(
                children: <Widget>[
                  const Icon(
                    CupertinoIcons.add_circled,
                    color: MyColors.red,
                    size: 24.0,
                  ),
                  Text(
                    appTranslations.text('add_delimiter'),
                    style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
