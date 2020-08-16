import 'package:built_redux/built_redux.dart';
import 'package:flutter/widgets.dart' hide Action;
import 'package:multi_debugger/domain/actions/actions.dart';
import 'package:multi_debugger/domain/models/app_routes.dart';
import 'package:multi_debugger/domain/models/models.dart';
import 'package:multi_debugger/domain/states/app_state.dart';

// BuildContext _activeRouteContext;

MiddlewareBuilder<AppState, AppStateBuilder, AppActions> createNavigationMiddleware() {
  return MiddlewareBuilder<AppState, AppStateBuilder, AppActions>()..add(AppActionsNames.routeTo, _routeTo);
}

// NavigatorState get rootNavigator => di.get<AppGlobals>().rootNavigatorKey.currentState;

void _routeTo(
  MiddlewareApi<AppState, AppStateBuilder, AppActions> api,
  ActionHandler next,
  Action<AppRoute> action,
) async {
  next(action);

  final AppRoute payload = action.payload;

  // if (payload.context != null) {
  //   _activeRouteContext = payload.context as BuildContext;
  // }

  switch (payload.route) {
    case AppRoutes.addChannel:
      break;
  }
}
