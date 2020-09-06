import 'package:built_redux/built_redux.dart';
import 'package:flutter/foundation.dart';
import 'package:multi_debugger/domain/actions/actions.dart';
import 'package:multi_debugger/domain/actions/app_config_actions.dart';
import 'package:multi_debugger/domain/states/states.dart';
import 'package:multi_debugger/services/local_station_service/local_station_service.dart';
import 'package:multi_debugger/services/logger_service/logger_service.dart';
import 'package:rxdart/rxdart.dart';

class LocalStationEpic {
  LocalStationEpic({
    @required this.localStationService,
    @required this.loggerService,
  })  : assert(localStationService != null),
        assert(loggerService != null);

  final LocalStationService localStationService;
  final LoggerService loggerService;

  Stream getComputerName(Stream<Action<dynamic>> stream, MiddlewareApi<AppState, AppStateBuilder, AppActions> api) {
    return stream
        .where((Action<dynamic> action) => action.name == AppConfigActionsNames.fetchComputerName.name)
        .debounceTime(const Duration(seconds: 1))
        .asyncMap((Action<dynamic> action) => localStationService.fetchComputerName())
        .doOnData((String name) {
      api.actions.appConfigActions.setComputerName(name);
    }).handleError((dynamic error) {
      loggerService.e('getComputerName error: $error');
    });
  }
}
