import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:multi_debugger/app/colors.dart';
import 'package:multi_debugger/domain/models/models.dart';
import 'package:multi_debugger/domain/states/states.dart';
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
      stream: _bloc.channelState,
      builder: (_, snapshot) {
        final ChannelState channelState = snapshot.data;

        return CustomScrollView(
          controller: _scrollController,
          slivers: [
            // channels
            ..._sliverChannels(channelState),

            // add new
            SliverToBoxAdapter(
              child: GestureDetector(
                onTap: () {
                  _bloc.addNew();

                  Future.delayed(const Duration(milliseconds: 300), () {
                    _scrollController.animateTo(
                      _scrollController.position.maxScrollExtent,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeOut,
                    );
                  });
                },
                child: const _Button(
                  child: RepaintBoundary(
                    child: Icon(
                      LoggerIcons.addNew_1x,
                      color: AppColors.positive,
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Iterable<Widget> _sliverChannels(ChannelState channelState) {
    if (channelState == null) {
      return [];
    }

    final BuiltMap<String, ChannelModel> channels = channelState.channels;

    return channels.values.map((ChannelModel channelModel) {
      final bool connected = channelModel.serverConnectStatus == ServerConnectStatus.connected;
      final Color bgColor = connected ? AppColors.positive : AppColors.background;
      final Color textColor = connected ? AppColors.channelActiveTitle : AppColors.channelInactiveTitle;

      return SliverToBoxAdapter(
        child: Stack(
          overflow: Overflow.visible,
          children: [
            // is current
            if (channelModel.isCurrent)
              const Positioned(
                top: 20.0,
                child: _CurrentWidget(),
              ),

            // channel
            GestureDetector(
              onTap: () => _bloc.updateChannel(channelModel),
              child: _Button(
                bgColor: bgColor,
                child: RepaintBoundary(
                  child: Text(
                    channelModel.shortName,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: textColor),
                  ),
                ),
              ),
            ),

            // status
            Positioned(
              left: 70.0 - 5.0,
              top: 70.0,
              child: _Status(
                serverConnectStatus: channelModel.serverConnectStatus,
              ),
            ),
          ],
        ),
      );
    });
  }
}

//
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

//
class _Status extends StatelessWidget {
  const _Status({
    Key key,
    @required this.serverConnectStatus,
  })  : assert(serverConnectStatus != null),
        super(key: key);

  final ServerConnectStatus serverConnectStatus;

  @override
  Widget build(BuildContext context) {
    final Color bgColor =
        serverConnectStatus == ServerConnectStatus.connected ? AppColors.channelConnected : AppColors.gray5;

    return Container(
      width: 20.0,
      height: 20.0,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10.0)),
        border: Border.all(color: AppColors.background, width: 2.0),
        boxShadow: [
          const BoxShadow(
            color: AppColors.gray4,
            offset: Offset(0, 1),
            blurRadius: 1,
          )
        ],
        color: bgColor,
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<ServerConnectStatus>('serverConnectStatus', serverConnectStatus));
  }
}

//
class _Button extends StatelessWidget {
  const _Button({
    Key key,
    this.child,
    this.bgColor = AppColors.background,
  }) : super(key: key);

  final Widget child;
  final Color bgColor;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.only(top: 20.0),
        child: Container(
          width: 70.0,
          height: 70.0,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(35.0)),
            boxShadow: [
              const BoxShadow(
                color: Color(0x33000000),
                offset: Offset(0, 1),
                blurRadius: 1,
              ),
            ],
            color: bgColor,
          ),
          child: Center(
            child: child,
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
