import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:multi_debugger/app/colors.dart';
import 'package:multi_debugger/domain/models/models.dart';
import 'package:multi_debugger/tools/logger_icons.dart';

import 'channel_actions_bloc.dart';

class ChannelActionsWidget extends StatefulWidget {
  const ChannelActionsWidget({
    Key key,
  }) : super(key: key);

  @override
  State createState() => _ChannelActionsWidgetState();
}

class _ChannelActionsWidgetState extends State<ChannelActionsWidget> {
  ChannelActionsBloc _bloc;
  // final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    _bloc = ChannelActionsBloc()..init();
  }

  @override
  void dispose() {
    _bloc.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ChannelModel>(
      initialData: _bloc.currentChannelModel,
      stream: _bloc.currentChannelModelStream,
      builder: (_, snapshot) {
        final ChannelModel currentChannelModel = snapshot.data;
        final bool existsChannel = snapshot.hasData;

        final bool showFavorites = existsChannel && currentChannelModel.showFavoriteOnly;
        final bool showWhiteList = existsChannel && currentChannelModel.isWhiteListUsed;
        final bool showBlackList = existsChannel && currentChannelModel.isBlackListUsed;
        final bool useAutoScroll = existsChannel && currentChannelModel.useAutoScroll;

        return Row(
          children: [
            // favorite
            _Button(
              icon: LoggerIcons.favoriteActive_1x,
              title: 'Favorite',
              used: showFavorites,
              callback: () => _bloc.toggleUseFavorites(context),
            ),

            // white list
            _Button(
              icon: LoggerIcons.whitelistActive_1x,
              title: 'White list',
              used: showWhiteList,
              usedColor: AppColors.primaryColor,
              callback: () => _bloc.toggleUseWhiteList(context),
              dropDownCallback: () => _bloc.showWhiteList(context),
            ),

            // black list
            _Button(
              icon: LoggerIcons.blacklistActive_1x,
              title: 'Black list',
              used: showBlackList,
              usedColor: AppColors.gray6,
              callback: () => _bloc.toggleUseBlackList(context),
              dropDownCallback: () => _bloc.showBlackList(context),
            ),

            const Padding(
              padding: EdgeInsets.only(left: 15.0),
              child: _Divider(),
            ),

            // add divider
            _Button(
              icon: LoggerIcons.divider_1x,
              title: 'Add divider',
              used: existsChannel,
              withDropDown: false,
              usedColor: AppColors.eventDelimiter,
              callback: () => _bloc.addDivider(context),
            ),

            const Padding(
              padding: EdgeInsets.only(left: 15.0),
              child: _Divider(),
            ),

            // use autoscroll
            _Button(
              icon: LoggerIcons.autoscroll_1x,
              title: 'Autoscroll',
              used: useAutoScroll,
              withDropDown: false,
              usedColor: AppColors.gray5,
              callback: () => _bloc.useAutoScroll(context),
            ),

            const Padding(
              padding: EdgeInsets.only(left: 15.0),
              child: _Divider(),
            ),

            // clear all
            _Button(
              icon: LoggerIcons.close_1x,
              title: 'Clear all',
              used: existsChannel,
              withDropDown: false,
              usedColor: AppColors.red,
              callback: () => _bloc.clearAll(context),
            ),
          ],
        );
      },
    );
  }
}

class _Button extends StatelessWidget {
  const _Button({
    Key key,
    @required this.icon,
    @required this.title,
    this.used = false,
    this.usedColor = AppColors.selected,
    this.withDropDown = true,
    this.callback,
    this.dropDownCallback,
  })  : assert(icon != null),
        assert(title != null),
        assert(used != null),
        assert(usedColor != null),
        assert(withDropDown != null),
        super(key: key);

  final IconData icon;
  final String title;
  final bool used;
  final Color usedColor;
  final bool withDropDown;
  // ignore: diagnostic_describe_all_properties
  final VoidCallback callback;
  // ignore: diagnostic_describe_all_properties
  final VoidCallback dropDownCallback;

  double get _iconWidth => withDropDown ? 52.0 : 78.0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // content
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // icon
              InkWell(
                onTap: callback,
                child: Container(
                  width: _iconWidth,
                  height: 36.0,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(6.0)),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.gray4,
                        offset: Offset(0, 1),
                        blurRadius: 1,
                      )
                    ],
                    color: AppColors.background,
                  ),
                  child: Icon(
                    icon,
                    color: used ? usedColor : AppColors.gray3,
                    size: 20.0,
                  ),
                ),
              ),

              // drop down
              if (withDropDown)
                InkWell(
                  onTap: dropDownCallback,
                  child: Container(
                    width: 24,
                    height: 36,
                    padding: const EdgeInsets.only(left: 2.0),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(6.0)),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.gray4,
                          offset: Offset(0, 1),
                          blurRadius: 1,
                        )
                      ],
                      color: AppColors.background,
                    ),
                    child: const Icon(
                      LoggerIcons.arrowDown_1x,
                      color: AppColors.gray5,
                      size: 14.0,
                    ),
                  ),
                ),
            ],
          ),

          // title
          Padding(
            padding: const EdgeInsets.only(top: 6.0),
            child: Text(
              title,
              style: const TextStyle(
                color: AppColors.gray6,
                fontSize: 11.0,
              ),
              // textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<IconData>('icon', icon));
    properties.add(DiagnosticsProperty<bool>('withDropDown', withDropDown));
    properties.add(DiagnosticsProperty<bool>('used', used));
    properties.add(ColorProperty('usedColor', usedColor));
    properties.add(StringProperty('title', title));
  }
}

class _Divider extends StatelessWidget {
  const _Divider({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.0,
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: AppColors.gray3,
            offset: Offset(1, 1),
          ),
        ],
        color: AppColors.gray1,
      ),
    );
  }
}
