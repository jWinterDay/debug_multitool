import 'package:built_redux/built_redux.dart';
// import 'package:multi_debugger/di/app_di.dart';
import 'package:multi_debugger/domain/actions/actions.dart';
// import 'package:multi_debugger/domain/built_redux_rx.dart';
// import 'package:multi_debugger/domain/epics/remote_epic.dart';
import 'package:multi_debugger/domain/states/states.dart';

import 'channel_middleware.dart';

Iterable<Middleware<AppState, AppStateBuilder, AppActions>> get appMiddlewares => [
      // middlewares
      createChannelMiddleware().build(),

      // epics
      // createEpicMiddleware([
      //   di.get<RemoteEpic>().fetchRemoteConfig,
      //   // fetchRemoteConfig
      // ]),
    ];
