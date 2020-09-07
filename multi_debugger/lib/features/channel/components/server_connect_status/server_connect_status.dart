import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:multi_debugger/app/colors.dart';
import 'package:multi_debugger/domain/models/models.dart';

class ConnectStatusWidget extends StatelessWidget {
  const ConnectStatusWidget({
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
