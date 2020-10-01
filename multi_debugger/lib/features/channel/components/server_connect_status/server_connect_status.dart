import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:multi_debugger/app/colors.dart';
import 'package:multi_debugger/domain/models/models.dart';
import 'package:multi_debugger/features/channel/components/server_connect_status/server_connect_status_bloc.dart';

class ConnectStatusWidget extends StatefulWidget {
  const ConnectStatusWidget({
    Key key,
    @required this.channelModel,
    this.useCounter = false,
  })  : assert(channelModel != null),
        assert(useCounter != null),
        super(key: key);

  final ChannelModel channelModel;
  final bool useCounter;

  @override
  _ConnectStatusWidgetState createState() => _ConnectStatusWidgetState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<ChannelModel>('channelModel', channelModel));
    properties.add(DiagnosticsProperty<bool>('useCounter', useCounter));
  }
}

class _ConnectStatusWidgetState extends State<ConnectStatusWidget> {
  ConnectStatusBloc _bloc;

  @override
  void initState() {
    super.initState();

    _bloc = ConnectStatusBloc(widgetChannelModel: widget.channelModel)..init();
  }

  @override
  void dispose() {
    _bloc.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ServerConnectStatus status = widget.channelModel.serverConnectStatus;
    final Color bgColor = status == ServerConnectStatus.connected ? AppColors.channelConnected : AppColors.gray5;

    return StreamBuilder<int>(
      initialData: 0,
      stream: _bloc.unreadEventsCountStream,
      builder: (_, snapshot) {
        final int unreadEventCount = snapshot.data;
        final bool showCounter = widget.useCounter && unreadEventCount != 0;

        final String displayMessage = unreadEventCount > 99 ? '99+' : unreadEventCount.toString();

        return Container(
          width: showCounter ? 32.0 : 20.0,
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
          alignment: Alignment.center,
          child: showCounter
              ? Text(
                  displayMessage,
                  style: const TextStyle(
                    color: AppColors.background,
                    fontSize: 11.0,
                  ),
                )
              : null,
        );
      },
    );
  }
}
