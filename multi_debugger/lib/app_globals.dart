import 'dart:convert';

import 'package:built_redux/built_redux.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:multi_debugger/domain/actions/actions.dart';
import 'package:multi_debugger/domain/middlewares/middlewares.dart';
import 'package:multi_debugger/domain/states/states.dart';
import 'package:multi_debugger/domain/reducers/reducer_builder.dart';
import 'package:multi_debugger/domain/serializers.dart';
import 'package:multi_debugger/services/logger_service/logger_service.dart';

class AppGlobals {
  AppGlobals({
    @required this.loggerService,
  }) : assert(loggerService != null);

  final LoggerService loggerService;

  final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();
  Store<AppState, AppStateBuilder, AppActions> _store;
  Store<AppState, AppStateBuilder, AppActions> get store => _store;

  // init globals
  Future<void> init() async {
    await _initStore();
    await _initLocalSettingsState();
  }

  // init redux store
  Future<void> _initStore() async {
    _store = Store<AppState, AppStateBuilder, AppActions>(
      reducers,
      AppState(
        (builder) => builder
          // ..channelState = ChannelState().toBuilder()
          ..appConfigState = AppConfigState().toBuilder(),
      ),
      AppActions(),
      middleware: appMiddlewares,
    );
  }

  // init user specific settings
  Future<void> _initLocalSettingsState() async {
    final LocalSettingsState localSettingsState = await _loadLocalSettingsState();

    store.actions.appConfigActions.setLocalSettings(localSettingsState);
  }

  /// load local user settings
  Future<LocalSettingsState> _loadLocalSettingsState() async {
    String data;

    try {
      data = await rootBundle.loadString('application_bundle/local_settings.json');
    } catch (error, stackTrace) {
      loggerService.e(error, error.runtimeType, stackTrace);
    }

    if (data == null) {
      return LocalSettingsState();
    }

    return serializers.deserializeWith(LocalSettingsState.serializer, json.decode(data));
  }
}
