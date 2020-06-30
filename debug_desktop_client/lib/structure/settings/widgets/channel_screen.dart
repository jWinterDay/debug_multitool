import 'package:debug_desktop_client/mobx/app_settings_state.dart';
import 'package:debug_desktop_client/structure/settings/widgets/components/log_actions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:debug_desktop_client/app_translations.dart';
import 'package:debug_desktop_client/mobx/channel.dart';
import 'package:debug_desktop_client/mobx/channel_state.dart';
import 'package:debug_desktop_client/mobx/connect_status.dart';
import 'package:debug_desktop_client/mobx/log.dart';
import 'package:debug_desktop_client/structure/settings/widgets/channel_card.dart';
import 'package:debug_desktop_client/structure/settings/widgets/channel_full_info.dart';
import 'package:debug_desktop_client/tools/uikit.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import 'components/black_list_input.dart';
import 'components/url_input.dart';
import 'components/white_list_input.dart';

class ChannelScreen extends StatefulWidget {
  const ChannelScreen(this.channel);

  final Channel channel;

  @override
  _ChannelState createState() => _ChannelState();
}

class _ChannelState extends State<ChannelScreen> {
  // url
  TextEditingController _urlEditingController;
  String get _currentUrl => _urlEditingController.text;

  // white list
  TextEditingController _whiteListEditingController;

  // black list
  TextEditingController _blackListEditingController;

  ScrollController _scrollController;

  @override
  void initState() {
    super.initState();

    _urlEditingController = TextEditingController(text: '');
    _whiteListEditingController = TextEditingController(text: '');
    _blackListEditingController = TextEditingController(text: '');

    _scrollController = ScrollController();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      // channel list store
      final ChannelState channelStateStore = Provider.of<ChannelState>(context, listen: false);

      channelStateStore.setCurrentChannel(widget.channel);

      _urlEditingController.text = channelStateStore.currentChannel.wsUrl;
      // _urlEditingController.addListener(() {
      //   channelStateStore.setChannelUrl(widget.channel, _currentUrl);
      // });

      // filter white list
      _whiteListEditingController.text = channelStateStore.currentChannel.filterWhiteList;
      _whiteListEditingController.addListener(() {
        channelStateStore.currentChannel.setFilterWhite(_whiteListEditingController.text);
      });

      // filter black list
      _blackListEditingController.text = channelStateStore.currentChannel.filterBlackList;
      _blackListEditingController.addListener(() {
        channelStateStore.currentChannel.setFilterBlack(_blackListEditingController.text);
      });
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();

    super.dispose();
  }

  int _currentIndex = -1;
  Log _currentLog;
  void _showDetails(Log log, int index) {
    setState(() {
      _currentLog = log;
      _currentIndex = index;
    });
  }

  void _setScrolling({bool scrollToEnd}) {
    final bool isExtentEmpty = _scrollController?.position?.maxScrollExtent == null;

    if (scrollToEnd && !isExtentEmpty) {
      _scrollController.animateTo(
        _scrollController?.position?.maxScrollExtent,
        curve: Curves.easeOut,
        duration: const Duration(milliseconds: 500),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final AppSettingsState appSettingsState = Provider.of<AppSettingsState>(context);

    final ChannelState channelStateStore = Provider.of<ChannelState>(context);
    if (channelStateStore?.currentChannel == null) {
      return Container();
    }
    final String name = appTranslations.text('channel_name') + ': ${widget.channel.name}';

    return CupertinoPageScaffold(
      resizeToAvoidBottomInset: true,
      navigationBar: CupertinoNavigationBar(
        transitionBetweenRoutes: false,
        middle: Text(name),
        trailing: GestureDetector(
          onTap: () {
            //
          },
          child: const Icon(CupertinoIcons.settings, size: 42.0),
        ),
        previousPageTitle: appTranslations.text('common_back'),
      ),
      child: Column(
        children: <Widget>[
          // url
          UrlInput(
            controller: _urlEditingController,
            channel: widget.channel,
          ),

          // filter white list
          Observer(builder: (_) {
            return WhiteListInput(
              controller: _whiteListEditingController,
              isWhiteListUsed: channelStateStore.currentChannel.isWhiteListUsed,
              callback: (val) => channelStateStore.currentChannel.useWhiteList(val),
            );
          }),

          // filter black list
          Observer(builder: (_) {
            return BlackListInput(
              controller: _blackListEditingController,
              isBlackListUsed: channelStateStore.currentChannel.isBlackListUsed,
              callback: (val) => channelStateStore.currentChannel.useBlackList(val),
            );
          }),

          // actions
          Observer(builder: (_) {
            return LogActions(
              channelStateStore: channelStateStore,
              clearCallback: channelStateStore.currentChannel.connectStatus == ConnectStatus.connecting
                  ? null
                  : () {
                      setState(() {
                        _currentIndex = -1;
                        _currentLog = null;
                      });

                      channelStateStore.currentChannel.clearLogs();
                    },
            );
          }),

          //
          Observer(builder: (_) {
            return Expanded(
              child: (widget.channel.connectStatus == ConnectStatus.connecting)
                  ? const CupertinoActivityIndicator(
                      radius: 72.0,
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        // list scroll
                        Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    _scrollController.jumpTo(0.0);
                                  },
                                  child: Container(
                                    color: MyColors.red.withOpacity(0.2),
                                    child: const Icon(CupertinoIcons.up_arrow),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
                                  },
                                  child: Container(
                                    color: MyColors.green.withOpacity(0.2),
                                    child: const Icon(CupertinoIcons.down_arrow),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        // content
                        Expanded(
                          flex: 1,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                            decoration: BoxDecoration(
                              color: MyColors.gray_e5e5e5,
                              borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                              border: Border.all(
                                width: 1.0,
                                color: MyColors.gray_666666,
                              ),
                            ),
                            child: CustomScrollView(
                              controller: _scrollController,
                              // reverse: true,
                              // shrinkWrap: true,
                              physics: const ClampingScrollPhysics(),
                              slivers: <Widget>[
                                // logs
                                Observer(
                                  builder: (_) {
                                    final scrollToEnd = appSettingsState.scrollToEnd;
                                    final List<Log> list = channelStateStore.currentChannel.filteredLogs;

                                    _setScrolling(scrollToEnd: scrollToEnd);

                                    return SliverList(
                                      delegate: SliverChildBuilderDelegate(
                                        (_, int index) {
                                          final Log log = list[index];

                                          return GestureDetector(
                                            onTap: log.enabled
                                                ? () {
                                                    _showDetails(log, index);
                                                  }
                                                : null,
                                            child: ChannelCardScreen(
                                              log: list[index],
                                              index: index,
                                              selected: index == _currentIndex,
                                            ),
                                          );
                                        },
                                        childCount: list.length,
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),

                        // full info
                        if (_currentLog != null)
                          Expanded(
                            flex: 2,
                            child: ChannelFullInfoScreen(
                              log: _currentLog,
                              // index: _currentIndex,
                            ),
                          ),
                      ],
                    ),
            );
          }),
        ],
      ),
    );
  }
}
