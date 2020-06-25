import 'package:debug_desktop_client/app_di.dart';
import 'package:debug_desktop_client/app_translations.dart';
import 'package:debug_desktop_client/mobx/channel.dart';
import 'package:debug_desktop_client/mobx/channel_state.dart';
import 'package:debug_desktop_client/mobx/connect_status.dart';
import 'package:debug_desktop_client/mobx/used_url.dart';
import 'package:debug_desktop_client/services/custom/used_url_service.dart';
import 'package:debug_desktop_client/structure/components/input_text.dart';
import 'package:debug_desktop_client/tools/uikit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';

class UrlInput extends StatefulWidget {
  UrlInput({
    @required this.controller,
    @required this.channel,
  }) : assert(controller != null);

  final TextEditingController controller;
  final Channel channel;

  @override
  State<StatefulWidget> createState() => _UrlInputState();
}

class _UrlInputState extends State<UrlInput> {
  UsedUrlService _usedUrlService = di.get<UsedUrlService>();
  // Future<List<UsedUrl>> _usedUrls;
  BehaviorSubject<bool> _enableSubject = BehaviorSubject();
  BehaviorSubject<List<UsedUrl>> _usedUrlsSubject = BehaviorSubject<List<UsedUrl>>();

  @override
  void initState() {
    super.initState();

    widget.controller.addListener(() {
      _enableSubject.add(widget.controller.text != '');
    });
  }

  @override
  void dispose() {
    _enableSubject.close();
    super.dispose();
  }

  Widget _urlList() {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        transitionBetweenRoutes: false,
        middle: Text(appTranslations.text('settings_select_url')),
        trailing: GestureDetector(
          onTap: () {
            _usedUrlService.deleteAll();

            _usedUrlService.fetch().then((List<UsedUrl> list) {
              _usedUrlsSubject.add(list);
            });
          },
          child: Icon(CupertinoIcons.delete),
        ),
        previousPageTitle: appTranslations.text('common_back'),
      ),
      child: StreamBuilder<List<UsedUrl>>(
        stream: _usedUrlsSubject,
        builder: (_, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CupertinoActivityIndicator(
                radius: 32.0,
              ),
            );
          }

          final List<UsedUrl> list = snapshot.data;

          return Container(
            margin: const EdgeInsets.all(16.0),
            child: CustomScrollView(
              physics: ClampingScrollPhysics(),
              slivers: [
                ...list.map((UsedUrl usedUrl) {
                  return SliverToBoxAdapter(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context, usedUrl.name);
                      },
                      child: Container(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        margin: const EdgeInsets.only(bottom: 8.0),
                        decoration: BoxDecoration(
                          color: usedUrl.isPermanent ? MyColors.green.withOpacity(0.1) : MyColors.gray_e5e5e5,
                          borderRadius: BorderRadius.all(Radius.circular(4.0)),
                        ),
                        child: Text(
                          usedUrl.name,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ],
            ),
          );
        },
      ),
    );
  }

  void _connect(ChannelState channelStateStore, {bool connected}) {
    if (!connected) {
      _usedUrlService.add(widget.controller.text);
    }

    channelStateStore.setChannelUrl(widget.channel, widget.controller.text);
    channelStateStore.setConnected(widget.channel, connected: !connected);
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final ChannelState channelStateStore = Provider.of<ChannelState>(context);

    return Observer(builder: (_) {
      final ConnectStatus connectStatus = channelStateStore.currentChannel?.connectStatus;
      final bool connected = [ConnectStatus.connected, ConnectStatus.connecting].contains(connectStatus);
      final String currentUrl = channelStateStore.currentChannel.wsUrl;
      widget.controller.text = currentUrl;

      final String urlButtonCaption = connected ? appTranslations.text('disconnect') : appTranslations.text('connect');

      return MyInputText(
        prefixWidget: GestureDetector(
          onTap: () async {
            _usedUrlService.fetch().then((List<UsedUrl> list) {
              _usedUrlsSubject.add(list);
            });

            String url = await showCupertinoDialog<String>(
              context: context,
              barrierDismissible: true,
              builder: (_) {
                return Center(
                  child: Container(
                    width: 0.8 * size.width,
                    height: 0.5 * size.height,
                    child: _urlList(),
                  ),
                );
              },
            );

            if (url != null) {
              channelStateStore.setChannelUrl(widget.channel, url);
            }
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('select url'),
              Icon(
                CupertinoIcons.search,
                color: MyColors.red,
              ),
            ],
          ),
        ),
        textEditingController: widget.controller,
        placeholder: 'web socket url',
        enabled: !connected,
        child: StreamBuilder<bool>(
          stream: _enableSubject,
          builder: (_, enabledSnapshot) {
            if (!enabledSnapshot.hasData) {
              return Container();
            }

            final bool enabled = enabledSnapshot.data;

            return GestureDetector(
              onTap: enabled ? () => _connect(channelStateStore, connected: connected) : null,
              child: Container(
                padding: const EdgeInsets.only(left: 24.0, right: 16.0),
                color: MyColors.transparent,
                child: Center(
                  child: Text(
                    urlButtonCaption,
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      fontWeight: FontWeight.bold,
                      color: enabled ? MyColors.black : MyColors.gray_999999,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      );
    });
  }
}
