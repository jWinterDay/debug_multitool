import 'package:built_redux/built_redux.dart';
import 'package:flutter/foundation.dart';
import 'package:multi_debugger/domain/actions/actions.dart';
import 'package:multi_debugger/domain/actions/app_config_actions.dart';
import 'package:multi_debugger/domain/models/models.dart';
import 'package:multi_debugger/domain/selectors/channel_selectors.dart';
import 'package:multi_debugger/domain/selectors/saved_url_selectors.dart';
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

  // get saved urls
  Stream getSavedUrls(Stream<Action<dynamic>> stream, MiddlewareApi<AppState, AppStateBuilder, AppActions> api) {
    return stream.where((Action<dynamic> action) {
      return action.name == AppConfigActionsNames.fetchSavedUrls.name;
    }).asyncMap((Action<dynamic> action) {
      return localStorageService.fetchSavedUrlList();
    }).doOnData((List<SavedUrl> savedUrlList) {
      api.actions.savedUrlActions.addAllUrl(savedUrlList);
    }).handleError((dynamic error) {
      loggerService.e('getComputerName error: $error');
    });
  }

  // get saved channels
  Stream getSavedChannels(Stream<Action<dynamic>> stream, MiddlewareApi<AppState, AppStateBuilder, AppActions> api) {
    return stream.where((Action<dynamic> action) {
      return action.name == AppConfigActionsNames.fetchSavedChannels.name;
    }).asyncMap((Action<dynamic> action) {
      return localStorageService.fetchSavedChannelsList();
    }).doOnData((Iterable<ChannelModel> savedChannelList) {
      api.actions.channelActions.addAllChannel(savedChannelList);
    }).handleError((dynamic error) {
      loggerService.e('getSavedChannels error: $error');
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

  // save channel state local
  Stream saveChannelStateLocal(
    Stream<Action<dynamic>> stream,
    MiddlewareApi<AppState, AppStateBuilder, AppActions> api,
  ) {
    return stream
        .where((Action<dynamic> action) {
          return ChannelSelectors.actionNames.contains(action.name);
        })
        .debounceTime(const Duration(milliseconds: 100))
        .doOnData((Action<dynamic> action) async {
          // ignore: unawaited_futures
          localStorageService.saveChannelState(api.state.channelState);
        })
        .handleError((dynamic error) {
          loggerService.e('saveChannelStateLocal error: $error');
        });
  }

  // save saved urls local
  Stream saveSavedUrlsLocal(Stream<Action<dynamic>> stream, MiddlewareApi<AppState, AppStateBuilder, AppActions> api) {
    return stream
        .where((Action<dynamic> action) {
          return SavedUrlSelectors.actionNames.contains(action.name);
        })
        .debounceTime(const Duration(milliseconds: 100))
        .doOnData((Action<dynamic> action) async {
          // ignore: unawaited_futures
          localStorageService.saveSavedUrls(api.state.savedUrlState);
        })
        .handleError((dynamic error) {
          loggerService.e('saveChannelStateLocal error: $error');
        });
  }
}
