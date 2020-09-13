import 'package:built_redux/built_redux.dart';
import 'package:multi_debugger/di/app_di.dart';
// import 'package:multi_debugger/di/app_di.dart';
import 'package:multi_debugger/domain/actions/actions.dart';
import 'package:multi_debugger/domain/built_redux_rx.dart';
import 'package:multi_debugger/domain/epics/server_connect_epic.dart';
import 'package:multi_debugger/domain/middlewares/navigation_middleware.dart';
import 'package:multi_debugger/domain/middlewares/server_event_middleware.dart';
import 'package:multi_debugger/domain/epics/local_epic.dart';
import 'package:multi_debugger/domain/states/states.dart';

import 'channel_middleware.dart';

Iterable<Middleware<AppState, AppStateBuilder, AppActions>> get appMiddlewares => [
      // middlewares
      createChannelMiddleware().build(),
      createNavigationMiddleware().build(),
      createServerEventMiddleware().build(),

      // epics
      createEpicMiddleware([
        di.get<LocalEpic>().getComputerName,
        di.get<LocalEpic>().getSavedUrls,
        di.get<LocalEpic>().getSavedChannels,
        di.get<LocalEpic>().saveChannelStateLocal,
        di.get<ServerConnectEpic>().connect,
      ]),
    ];
