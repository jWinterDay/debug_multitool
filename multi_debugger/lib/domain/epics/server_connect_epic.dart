import 'package:built_redux/built_redux.dart';
import 'package:flutter/foundation.dart';
import 'package:multi_debugger/domain/actions/actions.dart';
import 'package:multi_debugger/domain/actions/channel_actions.dart';
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
      final ChannelModel channelModel = action.payload as ChannelModel;

      final ServerConnectStatus nextStatus = channelModel.serverConnectStatus;
      final ServerCommunicateService service =
          api.state.serverCommunicateServicesState.services[channelModel.channelId];

      switch (nextStatus) {
        case ServerConnectStatus.disconnected:
          service.disconnect();
          break;
        case ServerConnectStatus.connecting:
          service.connect(channelModel);
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
