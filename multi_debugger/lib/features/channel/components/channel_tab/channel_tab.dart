import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:multi_debugger/app/colors.dart';
import 'package:multi_debugger/domain/models/models.dart';
import 'package:multi_debugger/domain/states/states.dart';
import 'package:multi_debugger/features/channel/components/server_connect_status/server_connect_status.dart';
import 'package:multi_debugger/tools/logger_icons.dart';

import 'channel_tab_bloc.dart';

class ChannelTab extends StatefulWidget {
  const ChannelTab({
    Key key,
  }) : super(key: key);

  @override
  State createState() => _ChannelTabState();
}

class _ChannelTabState extends State<ChannelTab> {
  ChannelTabBloc _bloc;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    _bloc = ChannelTabBloc()..init();
  }

  @override
  void dispose() {
    _bloc.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ChannelState>(
      stream: _bloc.channelStateStream,
      builder: (_, snapshot) {
        final ChannelState channelState = snapshot.data;

        final List<ChannelModel> channels = !snapshot.hasData ? [] : channelState.channels.values.toList();

        return CustomScrollView(
          controller: _scrollController,
          slivers: [
            // channels
            if (channelState != null)
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return _item(
                      channels[index],
                    );
                  },
                  childCount: channels.length,
                ),
              ),

            // add new
            SliverToBoxAdapter(
              child: _Button(
                child: const RepaintBoundary(
                  child: Icon(
                    LoggerIcons.addNew_1x,
                    color: AppColors.positive,
                    size: 26.0,
                  ),
                ),
                callback: () {
                  _bloc.showAddChannel(context);

                  Future.delayed(const Duration(milliseconds: 300), () {
                    _scrollController.animateTo(
                      _scrollController.position.maxScrollExtent,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeOut,
                    );
                  });
                },
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _item(ChannelModel channelModel) {
    if (channelModel == null) {
      return Container();
    }

    final bool connected = channelModel.serverConnectStatus == ServerConnectStatus.connected;
    final Color bgColor = connected ? AppColors.positive : AppColors.background;
    final Color textColor = connected ? AppColors.channelActiveTitle : AppColors.channelInactiveTitle;

    return Stack(
      overflow: Overflow.visible,
      children: [
        // is current
        if (channelModel.isCurrent)
          const Positioned(
            top: 20.0,
            child: _CurrentWidget(),
          ),

        // short name
        _Button(
          bgColor: bgColor,
          child: Text(
            channelModel.shortName,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: TextStyle(color: textColor),
          ),
          callback: () => _bloc.setCurrent(channelModel),
        ),

        // status
        Positioned(
          left: 70.0 - 5.0,
          top: 70.0,
          child: ConnectStatusWidget(
            channelModel: channelModel,
            useCounter: true,
          ),
        ),
      ],
    );
  }
}

class _CurrentWidget extends StatelessWidget {
  const _CurrentWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 7.0,
      height: 70.0,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(35.0)),
        boxShadow: [
          BoxShadow(
            // color: Colors.gray4,
            offset: Offset(0, 1),
            blurRadius: 1,
          ),
        ],
        color: AppColors.positive,
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
    return Center(
      child: Container(
        padding: const EdgeInsets.only(top: 20.0),
        child: ClipOval(
          child: Material(
            color: bgColor,
            // elevation: 100.0,
            // shadowColor: Colors.black,
            // shape: BeveledRectangleBorder(
            //   borderRadius: BorderRadius.only(topLeft: Radius.circular(200.0)),
            // ),
            child: InkWell(
              splashColor: AppColors.gray2,
              hoverColor: AppColors.gray3,
              child: SizedBox(
                width: 70,
                height: 70,
                child: Center(
                  child: child,
                ),
              ),
              onTap: callback,
            ),
          ),
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
