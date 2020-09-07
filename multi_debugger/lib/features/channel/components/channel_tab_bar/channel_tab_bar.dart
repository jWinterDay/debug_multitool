import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:multi_debugger/app/colors.dart';
import 'package:multi_debugger/domain/models/models.dart';
import 'package:multi_debugger/domain/states/states.dart';
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
    contentPadding: const EdgeInsets.all(0.0),
    filled: true,
    fillColor: AppColors.background,
    border: OutlineInputBorder(
      borderSide: const BorderSide(color: AppColors.gray3),
      borderRadius: BorderRadius.circular(6.0),
    ),
    focusedBorder: OutlineInputBorder(
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
          Row(
            children: [
              // channel unfo
              Row(
                children: [
                  // status
                  ConnectStatusWidget(serverConnectStatus: ServerConnectStatus.connected),

                  // channel name
                  Container(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Text(
                      "jwd_dev",
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
                      quarterTurns: 2,
                      child: Icon(
                        LoggerIcons.arrowDown_1x,
                        size: 25.0,
                        color: AppColors.gray6,
                      ),
                    ),
                  ),
                ],
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

          // url and connect
          Row(
            children: [
              // select url
              ButtonTheme(
                minWidth: 126.0,
                child: RaisedButton(
                  onPressed: () {},
                  child: Row(
                    children: [
                      const Icon(
                        LoggerIcons.search_1x,
                        color: AppColors.gray5,
                        size: 18.0,
                      ),
                      const SizedBox(
                        width: 8.0,
                      ),
                      const Text(
                        'Select URL',
                        style: TextStyle(
                          color: AppColors.bodyText2Color,
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

              // connect
              ButtonTheme(
                minWidth: 220.0,
                child: RaisedButton(
                  onPressed: () {},
                  child: Row(
                    children: [
                      const Icon(
                        LoggerIcons.connect_1x,
                        color: AppColors.background,
                        size: 18.0,
                      ),
                      const SizedBox(
                        width: 8.0,
                      ),
                      const Text(
                        'Connect',
                        style: TextStyle(
                          color: AppColors.background,
                          fontSize: 15.0,
                        ),
                      ),
                    ],
                  ),
                  color: AppColors.positive,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6.0),
                    side: const BorderSide(color: AppColors.gray4),
                  ),
                ),
              ),
            ],
          ),
          // Container(
          //   padding: const EdgeInsets.only(left: 15.0, top: 15.0),
          //   child: TextFormField(
          //     autofocus: true,
          //     // onChanged: _bloc.onNameChanged,
          //     cursorColor: AppColors.positive,

          //     style: const TextStyle(
          //       color: AppColors.bodyText2Color,
          //       fontSize: 15.0,
          //     ),
          //     textAlign: TextAlign.center,
          //     decoration: _inputDecoration.copyWith(hintText: 'URL'),
          //   ),
          // ),
        ],
      ),
    );
  }
}

class _Button extends StatelessWidget {
  const _Button({
    Key key,
    this.child,
    this.bgColor = AppColors.background,
    this.callback,
  }) : super(key: key);

  final Widget child;
  final Color bgColor;
  // ignore: diagnostic_describe_all_properties
  final VoidCallback callback;

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      minWidth: 126.0,
      child: RaisedButton(
        onPressed: () {},
        child: Row(
          children: [
            const Icon(
              LoggerIcons.search_1x,
              color: AppColors.gray5,
              size: 18.0,
            ),
            const SizedBox(
              width: 8.0,
            ),
            const Text(
              'Select URL',
              style: TextStyle(
                color: AppColors.bodyText2Color,
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
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);

    properties.add(ColorProperty('bgColor', bgColor));
  }
}
