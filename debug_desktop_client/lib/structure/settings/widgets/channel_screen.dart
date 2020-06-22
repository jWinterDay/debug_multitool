import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:debug_desktop_client/app_translations.dart';
import 'package:debug_desktop_client/mobx/channel.dart';
import 'package:debug_desktop_client/mobx/channel_list.dart';
import 'package:debug_desktop_client/mobx/connect_status.dart';
import 'package:debug_desktop_client/mobx/log.dart';
import 'package:debug_desktop_client/structure/settings/widgets/channel_card.dart';
import 'package:debug_desktop_client/structure/settings/widgets/channel_full_info.dart';
import 'package:debug_desktop_client/tools/uikit.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

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
      final ChannelList channelListStore = Provider.of<ChannelList>(context, listen: false);

      channelListStore.setCurrentChannel(widget.channel);

      _urlEditingController.text = channelListStore.currentChannel.wsUrl;
      _urlEditingController.addListener(() {
        channelListStore.setChannelUrl(widget.channel, _currentUrl);
      });

      // filter white list
      _whiteListEditingController.text = channelListStore.currentChannel.filterWhiteList;
      _whiteListEditingController.addListener(() {
        channelListStore.currentChannel.setFilterWhite(_whiteListEditingController.text);
      });

      // filter black list
      _blackListEditingController.text = channelListStore.currentChannel.filterBlackList;
      _blackListEditingController.addListener(() {
        channelListStore.currentChannel.setFilterBlack(_blackListEditingController.text);
      });
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();

    super.dispose();
  }

  Widget _input({
    String placeholder,
    @required TextEditingController textEditingController,
    bool enabled = true,
    BoxDecoration decoration,
    @required Widget child,
  }) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: const BoxDecoration(
        color: MyColors.gray_b3b3b3,
      ),
      child: Row(
        children: <Widget>[
          // header
          Expanded(
            child: CupertinoTextField(
              placeholder: placeholder,
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              controller: textEditingController,
              clearButtonMode: enabled ? OverlayVisibilityMode.always : OverlayVisibilityMode.never,
              decoration: decoration ?? BoxDecoration(color: enabled ? MyColors.white : MyColors.gray_d8d8d8),
              enabled: enabled,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),

          // child
          if (child != null) child,
        ],
      ),
    );
  }

  Widget _urlInput({
    @required ChannelList channelListStore,
  }) {
    final bool connected = channelListStore.currentChannel?.connectStatus == ConnectStatus.connected;
    final String urlButtonCaption = connected ? appTranslations.text('disconnect') : appTranslations.text('connect');

    return _input(
      textEditingController: _urlEditingController,
      placeholder: 'web socket url',
      enabled: !connected, // false,
      child: GestureDetector(
        onTap: () {
          channelListStore.setConnected(widget.channel, connected: !connected);
        },
        child: Container(
          padding: const EdgeInsets.only(left: 24.0, right: 16.0),
          color: MyColors.transparent,
          child: Center(
            child: Text(
              urlButtonCaption,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }

  Widget _whiteListInput({@required ChannelList channelListStore}) {
    final bool isWhiteListUsed = channelListStore.currentChannel.isWhiteListUsed;

    return _input(
      textEditingController: _whiteListEditingController,
      placeholder: 'white list',
      decoration: BoxDecoration(color: isWhiteListUsed ? MyColors.white : MyColors.gray_d8d8d8),
      child: Container(
        padding: const EdgeInsets.only(left: 24.0, right: 16.0),
        child: Row(
          children: <Widget>[
            const Text(
              'White list',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            CupertinoSwitch(
              value: isWhiteListUsed,
              onChanged: (bool val) {
                channelListStore.currentChannel.useWhiteList(val);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _blackListInput({@required ChannelList channelListStore}) {
    final bool isBlackListUsed = channelListStore.currentChannel.isBlackListUsed;

    return _input(
      textEditingController: _blackListEditingController,
      placeholder: 'black list',
      decoration: BoxDecoration(color: isBlackListUsed ? MyColors.white : MyColors.gray_d8d8d8),
      child: Container(
        padding: const EdgeInsets.only(left: 24.0, right: 16.0),
        child: Row(
          children: <Widget>[
            const Text(
              'Black list',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            CupertinoSwitch(
              value: isBlackListUsed,
              onChanged: (bool val) {
                channelListStore.currentChannel.useBlackList(val);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _actions({@required ChannelList channelListStore}) {
    return Container(
      decoration: const BoxDecoration(
        color: MyColors.gray_b3b3b3,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          // clear
          GestureDetector(
            onTap: channelListStore.currentChannel.connectStatus == ConnectStatus.connecting
                ? null
                : () {
                    setState(() {
                      _currentIndex = -1;
                      _currentLog = null;
                    });

                    channelListStore.currentChannel.clearLogs();
                  },
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
            onTap: channelListStore.currentChannel.connectStatus == ConnectStatus.connecting
                ? null
                : () {
                    final Log log = Log(
                      action: '------------------------',
                      actionPayload: 'test action payload',
                      state: 'test state',
                      enabled: false,
                    );
                    channelListStore.currentChannel.addLog(log);
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

  int _currentIndex = -1;
  Log _currentLog;
  void _showDetails(Log log, int index) {
    setState(() {
      _currentLog = log;
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final ChannelList channelListStore = Provider.of<ChannelList>(context);
    if (channelListStore?.currentChannel == null) {
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
          Observer(builder: (_) {
            return _urlInput(channelListStore: channelListStore);
          }),
          // filter white list
          Observer(builder: (_) {
            return _whiteListInput(channelListStore: channelListStore);
          }),
          // filter black list
          Observer(builder: (_) {
            return _blackListInput(channelListStore: channelListStore);
          }),
          // actions
          Observer(builder: (_) {
            return _actions(channelListStore: channelListStore);
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
                              physics: const ClampingScrollPhysics(),
                              slivers: <Widget>[
                                // logs
                                Observer(
                                  builder: (_) {
                                    final List<Log> list = channelListStore.currentChannel.filteredLogs;
                                    if (list != null &&
                                        list.isNotEmpty &&
                                        (_scrollController?.position?.maxScrollExtent ?? 0) > 0) {
                                      _scrollController.jumpTo(_scrollController.position?.maxScrollExtent ?? 0);
                                    }

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
                              index: _currentIndex,
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
