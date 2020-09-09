import 'package:built_redux/built_redux.dart';
import 'package:flutter/foundation.dart';
import 'package:multi_debugger/domain/actions/actions.dart';
import 'package:multi_debugger/domain/actions/app_config_actions.dart';
import 'package:multi_debugger/domain/models/saved_url.dart';
import 'package:multi_debugger/domain/states/states.dart';
import 'package:multi_debugger/services/local_station_service/local_station_service.dart';
import 'package:multi_debugger/services/local_storage_service/local_storage_service.dart';
import 'package:multi_debugger/services/logger_service/logger_service.dart';
import 'package:rxdart/rxdart.dart';

class LocalEpic {
  LocalEpic({
    @required this.localStationService,
    @required this.localStorageService,
    @required this.loggerService,
  })  : assert(localStationService != null),
        assert(loggerService != null);

  final LocalStationService localStationService;
  final LocalStorageService localStorageService;
  final LoggerService loggerService;

  // saved urls
  Stream getSavedUrls(Stream<Action<dynamic>> stream, MiddlewareApi<AppState, AppStateBuilder, AppActions> api) {
    return stream.where((Action<dynamic> action) {
      return action.name == AppConfigActionsNames.fetchLocalSettings.name;
    }).asyncMap((Action<dynamic> action) {
      return localStorageService.fetchSavedUrlList();
    }).doOnData((List<SavedUrl> savedUrlList) {
      api.actions.savedUrlActions.addAllUrl(savedUrlList);
      // api.actions.appConfigActions.setComputerName(name);
    }).handleError((dynamic error) {
      loggerService.e('getComputerName error: $error');
    });
  }

  // computer name
  Stream getComputerName(Stream<Action<dynamic>> stream, MiddlewareApi<AppState, AppStateBuilder, AppActions> api) {
    return stream
        .where((Action<dynamic> action) {
          return action.name == AppConfigActionsNames.fetchComputerName.name;
        })
        .debounceTime(const Duration(seconds: 1))
        .asyncMap((Action<dynamic> action) {
          return localStationService.fetchComputerName();
        })
        .doOnData((String name) {
          api.actions.appConfigActions.setComputerName(name);
        })
        .handleError((dynamic error) {
          loggerService.e('getComputerName error: $error');
        });
  }
}
