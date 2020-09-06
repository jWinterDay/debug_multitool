import 'package:built_redux/built_redux.dart';
import 'package:multi_debugger/domain/actions/actions.dart';
import 'package:multi_debugger/domain/states/states.dart';

class RemoteEpic {
  Stream fetchRemoteConfig(Stream<Action<dynamic>> stream, MiddlewareApi<AppState, AppStateBuilder, AppActions> api) {
    return null;
  }
}
