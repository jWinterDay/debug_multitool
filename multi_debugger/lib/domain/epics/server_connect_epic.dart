import 'package:built_redux/built_redux.dart';
import 'package:flutter/foundation.dart';
import 'package:multi_debugger/domain/actions/actions.dart';
import 'package:multi_debugger/domain/actions/channel_actions.dart';
import 'package:multi_debugger/domain/base/pair.dart';
import 'package:multi_debugger/domain/models/models.dart';
import 'package:multi_debugger/domain/states/states.dart';
import 'package:multi_debugger/services/logger_service/logger_service.dart';
import 'package:multi_debugger/services/server_communicate_service/server_communicate_service.dart';
import 'package:rxdart/rxdart.dart';

class ServerConnectEpic {
  ServerConnectEpic({
    @required this.loggerService,
  }) : assert(loggerService != null);

  final LoggerService loggerService;

  Stream connect(Stream<Action<dynamic>> stream, MiddlewareApi<AppState, AppStateBuilder, AppActions> api) {
    return stream.where((Action<dynamic> action) {
      return action.name == ChannelActionsNames.changeConnectStatus.name;
    }).doOnData((Action<dynamic> action) {
      final Pair<ChannelModel, ServerConnectStatus> pair = action.payload as Pair<ChannelModel, ServerConnectStatus>;

      final ChannelModel channelModel = pair.first;
      final ServerConnectStatus nextStatus = pair.second;
      final String channelId = channelModel.channelId;

      final ServerCommunicateService service = api.state.serverCommunicateServicesState.getService(channelId);

      switch (nextStatus) {
        case ServerConnectStatus.disconnected:
          service.disconnect();
          break;
        case ServerConnectStatus.connecting:
          String computerName = api.state.appConfigState.computerName?.trim() ?? '';
          String compositeChannelName = computerName + '_' + channelModel.name;
          service.connect(channelModel, compositeChannelName);
          break;
        case ServerConnectStatus.connected:
          break;
        default:
      }
    }).handleError((dynamic error) {
      loggerService.e('connect error: $error', 'ServerConnectEpic', StackTrace.current);
    });
  }
}
