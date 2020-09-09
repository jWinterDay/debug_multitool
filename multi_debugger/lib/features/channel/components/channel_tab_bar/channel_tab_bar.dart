import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:multi_debugger/app/colors.dart';
import 'package:multi_debugger/domain/models/models.dart';
import 'package:multi_debugger/features/channel/components/server_connect_status/server_connect_status.dart';
import 'package:multi_debugger/tools/logger_icons.dart';

import 'channel_tab_bar_bloc.dart';

class ChannelTabBar extends StatefulWidget {
  const ChannelTabBar({
    Key key,
  }) : super(key: key);

  @override
  State createState() => _ChannelTabBarState();
}

class _ChannelTabBarState extends State<ChannelTabBar> {
  TabBarBloc _bloc;
  final InputDecoration _inputDecoration = InputDecoration(
    filled: true,
    hintText: 'URL',
    fillColor: AppColors.background,
    border: OutlineInputBorder(
      borderSide: const BorderSide(color: AppColors.gray3),
      borderRadius: BorderRadius.circular(6.0),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: AppColors.gray3),
      borderRadius: BorderRadius.circular(6.0),
    ),
    disabledBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: AppColors.gray3),
      borderRadius: BorderRadius.circular(6.0),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: AppColors.gray3),
      borderRadius: BorderRadius.circular(6.0),
    ),
    hintStyle: const TextStyle(
      color: AppColors.gray5,
      fontSize: 15.0,
    ),
  );

  @override
  void initState() {
    super.initState();

    _bloc = TabBarBloc()..init();
  }

  @override
  void dispose() {
    _bloc.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 25.0, left: 15.0),
      child: Column(
        children: [
          // channel name and user profile
          Row(
            children: [
              // channel info
              StreamBuilder<ChannelModel>(
                initialData: _bloc.currentChannelModel,
                stream: _bloc.currentChannelModelStream,
                builder: (_, snapshot) {
                  if (!snapshot.hasData) {
                    return const SizedBox();
                  }

                  final ChannelModel currentChannelModel = snapshot.data;

                  return Row(
                    children: [
                      // status
                      ConnectStatusWidget(
                        serverConnectStatus: currentChannelModel.serverConnectStatus,
                      ),

                      // channel name
                      Container(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Text(
                          currentChannelModel.name,
                          style: const TextStyle(
                            color: AppColors.gray6,
                            fontWeight: FontWeight.w700,
                            fontSize: 22.0,
                          ),
                        ),
                      ),

                      // arrow
                      Container(
                        padding: const EdgeInsets.only(left: 6.0),
                        child: const RotatedBox(
                          quarterTurns: 0,
                          child: Icon(
                            LoggerIcons.arrowDown_1x,
                            size: 25.0,
                            color: AppColors.gray6,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),

              Expanded(child: Container()),

              // user info
              Row(
                children: [
                  // user avatar
                  Container(
                    width: 32.0,
                    height: 32.0,
                    decoration: const BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(16.0)),
                      color: AppColors.gray3,
                    ),
                    child: const Center(
                      child: Text(
                        'AP',
                        style: const TextStyle(color: const Color(0xffffffff), fontSize: 13.0),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),

                  // user name
                  Container(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: const Text(
                      'A P',
                      style: const TextStyle(
                        color: AppColors.gray6,
                        fontWeight: FontWeight.w400,
                        fontSize: 17.0,
                      ),
                      textAlign: TextAlign.right,
                    ),
                  ),

                  // arrow
                  Container(
                    padding: const EdgeInsets.only(left: 6.0, right: 15.0),
                    child: const Icon(
                      LoggerIcons.arrowDown_1x,
                      size: 25.0,
                      color: AppColors.gray6,
                    ),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 15.0),

          // url and connect
          StreamBuilder<ChannelModel>(
            initialData: _bloc.currentChannelModel,
            stream: _bloc.currentChannelModelStream,
            builder: (context, snapshot) {
              final ChannelModel channelModel = snapshot.data;

              final bool hasCurrentChannel = channelModel != null;
              ServerConnectStatus serverConnectStatus = channelModel?.serverConnectStatus;
              serverConnectStatus ??= ServerConnectStatus.disconnected;

              // select url
              final bool inConnect = ServerConnectStatus.inConnect.contains(serverConnectStatus);
              // url
              final bool urlEnabled = hasCurrentChannel && ServerConnectStatus.disconnected == serverConnectStatus;
              // button
              Widget connectWidget = const Icon(
                LoggerIcons.connect_1x,
                color: AppColors.background,
                size: 18.0,
              );
              Color bgColor;
              String text = 'CONNECT';

              switch (serverConnectStatus) {
                case ServerConnectStatus.disconnected:
                  bgColor = AppColors.channelConnected;
                  break;
                case ServerConnectStatus.connecting:
                  connectWidget = const SizedBox(
                    width: 18.0,
                    height: 18.0,
                    child: CircularProgressIndicator(),
                  );
                  bgColor = AppColors.channelConnecting;
                  break;
                case ServerConnectStatus.connected:
                  connectWidget = const Icon(
                    LoggerIcons.disconnect_1x,
                    color: AppColors.background,
                    size: 18.0,
                  );
                  bgColor = AppColors.gray5;
                  text = 'DISCONNECT';
                  break;
              }

              Color selectUrlColor;
              if (inConnect) {
                selectUrlColor = AppColors.background;
              } else if (!hasCurrentChannel) {
                selectUrlColor = AppColors.gray3;
              } else {
                selectUrlColor = AppColors.bodyText2Color;
              }

              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // select url
                  Container(
                    height: 36.0,
                    child: ButtonTheme(
                      minWidth: 126.0,
                      child: RaisedButton(
                        onPressed: (inConnect || !hasCurrentChannel) ? null : () => _bloc.showSelectUrl(context),
                        disabledColor: AppColors.gray5,
                        child: Row(
                          children: [
                            Icon(
                              LoggerIcons.search_1x,
                              color: inConnect ? AppColors.background : AppColors.gray3,
                              size: 18.0,
                            ),
                            const SizedBox(
                              width: 8.0,
                            ),
                            Text(
                              'Select URL',
                              style: TextStyle(
                                color: selectUrlColor,
                                fontSize: 15.0,
                              ),
                            ),
                          ],
                        ),
                        color: AppColors.background,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6.0),
                          side: const BorderSide(color: AppColors.gray4),
                        ),
                      ),
                    ),
                  ),

                  // url
                  Expanded(
                    child: Container(
                      height: 45.0,
                      padding: const EdgeInsets.only(left: 15.0),
                      child: TextField(
                        controller: _bloc.urlTextController,
                        autofocus: true,
                        enabled: urlEnabled,
                        cursorColor: AppColors.positive,
                        style: const TextStyle(
                          color: AppColors.bodyText2Color,
                          fontSize: 15.0,
                        ),
                        textAlign: TextAlign.center,
                        decoration:
                            inConnect ? _inputDecoration.copyWith(fillColor: AppColors.gray5) : _inputDecoration,
                      ),
                    ),
                  ),

                  // connect
                  if (hasCurrentChannel)
                    StreamBuilder<bool>(
                      initialData: false,
                      stream: _bloc.enabledConnectBtnStream,
                      builder: (_, enabledSnapshot) {
                        final bool enabled = enabledSnapshot.data ?? false;

                        return Container(
                          height: 36.0,
                          padding: const EdgeInsets.only(left: 15.0),
                          child: ButtonTheme(
                            minWidth: 220.0,
                            child: RaisedButton(
                              onPressed: enabled ? () => _bloc.connect() : null,
                              child: Row(
                                children: [
                                  connectWidget,
                                  const SizedBox(
                                    width: 8.0,
                                  ),
                                  Text(
                                    text,
                                    style: const TextStyle(
                                      color: AppColors.background,
                                      fontSize: 15.0,
                                    ),
                                  ),
                                ],
                              ),
                              color: bgColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6.0),
                                side: const BorderSide(color: AppColors.gray4),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
