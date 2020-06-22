import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:debug_desktop_client/app_config.dart';
import 'package:provider/provider.dart';

import 'package:debug_desktop_client/app_translations.dart';
import 'package:debug_desktop_client/mobx/channel.dart';
import 'package:debug_desktop_client/mobx/channel_list.dart';
import 'package:debug_desktop_client/structure/back_animation/utils/cool_route.dart';
import 'package:debug_desktop_client/structure/settings/widgets/channel_screen.dart';
import 'package:debug_desktop_client/tools/uikit.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../mobx/connect_status.dart';
import 'channel_dialog.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen();

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  Future<void> _navigateToChannel(Channel channel) async {
    await AppConfig.rootNavigator.push<dynamic>(
      CoolRoute<dynamic>(
        barrierColor: Colors.black.withOpacity(0.5),
        builder: (_) => ChannelScreen(channel),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final ChannelList _store = Provider.of<ChannelList>(context);

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        transitionBetweenRoutes: false,
        middle: Text(appTranslations.text('settings')),
        trailing: GestureDetector(
          child: const Icon(
            CupertinoIcons.add,
            size: 42.0,
          ),
          onTap: () async {
            await showCupertinoModalPopup<String>(
              context: context,
              builder: (_) => const ChannelDialogScreen(),
            );
          },
        ),
        previousPageTitle: appTranslations.text('common_back'),
      ),
      child: CustomScrollView(
        physics: const ClampingScrollPhysics(),
        slivers: <Widget>[
          Observer(
            builder: (_) {
              return SliverList(
                delegate: SliverChildListDelegate(
                  <Widget>[
                    // empty
                    if (_store.channelList.isEmpty)
                      Container(
                        height: size.height,
                        child: Center(
                          child: Text(
                            appTranslations.text('settings_no_channels'),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),

                    // data
                    ..._store.channelList.map((Channel channel) {
                      return GestureDetector(
                        onTap: () async {
                          Provider.of<ChannelList>(context, listen: false).setCurrentChannel(channel);
                          await _navigateToChannel(channel);
                          Provider.of<ChannelList>(context, listen: false).setCurrentChannel(null);
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                          margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                          decoration: BoxDecoration(
                            color: channel.connectStatus == ConnectStatus.connected
                                ? MyColors.green.withOpacity(0.1)
                                : MyColors.white,
                            borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                            border: Border.all(
                              width: 1.0,
                              color: MyColors.gray_666666,
                            ),
                          ),
                          child: Row(
                            children: <Widget>[
                              Container(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: Icon(
                                  CupertinoIcons.circle_filled,
                                  color: channel.connectStatus == ConnectStatus.connected
                                      ? MyColors.green
                                      : MyColors.gray_666666,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  channel.name,
                                  style: const TextStyle(fontSize: 18.0),
                                ),
                              ),
                              CupertinoButton(
                                child: Text(appTranslations.text('common_remove')),
                                color: MyColors.red.withOpacity(0.5),
                                onPressed: () {
                                  _store.removeChannel(channel);
                                },
                              ),
                              CupertinoButton(
                                child: Text('fetch'),
                                color: MyColors.red.withOpacity(0.5),
                                onPressed: () {
                                  _store.fetch();
                                  // _store.removeChannel(channel);
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                  ],
                ),
              );
            },
          ),

          // safearea
          SliverToBoxAdapter(
            child: SafeArea(
              child: Container(height: 16.0),
              top: false,
            ),
          ),
        ],
      ),
    );
  }
}
