import 'package:debug_desktop_client/app_translations.dart';
import 'package:debug_desktop_client/mobx/channel.dart';
import 'package:debug_desktop_client/mobx/channel_state.dart';
import 'package:debug_desktop_client/mobx/connect_status.dart';
import 'package:debug_desktop_client/structure/components/input_text.dart';
import 'package:debug_desktop_client/tools/uikit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

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
  bool _enabledButton = false;

  @override
  void initState() {
    super.initState();

    widget.controller.addListener(() {
      setState(() {
        _enabledButton = widget.controller.text != '';
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final ChannelState channelStateStore = Provider.of<ChannelState>(context);

    return Observer(builder: (_) {
      final ConnectStatus connectStatus = channelStateStore.currentChannel?.connectStatus;
      final bool connected = [ConnectStatus.connected, ConnectStatus.connecting].contains(connectStatus);

      final String urlButtonCaption = connected ? appTranslations.text('disconnect') : appTranslations.text('connect');

      return MyInputText(
        textEditingController: widget.controller,
        placeholder: 'web socket url',
        enabled: !connected,
        child: GestureDetector(
          onTap: _enabledButton
              ? () {
                  channelStateStore.setChannelUrl(widget.channel, widget.controller.text);
                  channelStateStore.setConnected(widget.channel, connected: !connected);
                }
              : null,
          child: Container(
            padding: const EdgeInsets.only(left: 24.0, right: 16.0),
            color: MyColors.transparent,
            child: Center(
              child: Text(
                urlButtonCaption,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: _enabledButton ? MyColors.black : MyColors.gray_999999,
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
