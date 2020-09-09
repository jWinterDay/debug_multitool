import 'dart:async';

import 'package:multi_debugger/domain/base/base_bloc.dart';
import 'package:multi_debugger/domain/states/server_event_state.dart';
import 'package:multi_debugger/domain/states/states.dart';
import 'package:rxdart/rxdart.dart';

class ActionsViewBloc extends BaseBloc {
  StreamSubscription<ServerEventState> _serverEventStateSubscription;

  BehaviorSubject<ServerEventState> _serverEventStateSubject;
  ServerEventState get initServerEventState => appGlobals.store.state.serverEventState;
  Stream<ServerEventState> get serverEventStateStream => _serverEventStateSubject.stream;

  @override
  void dispose() {
    _serverEventStateSubscription?.cancel();
    _serverEventStateSubject.close();

    super.dispose();
  }

  @override
  void init() {
    super.init();

    _serverEventStateSubject = BehaviorSubject<ServerEventState>();

    _serverEventStateSubscription = appGlobals.store.nextSubstate((AppState state) {
      return state;
    }).map((AppState state) {
      return state.serverEventState;
    }).listen((ServerEventState state) {
      _serverEventStateSubject.add(state);
    });
  }

  // List<SavedUrl> filterSavedUrl(SavedUrlState state, {bool custom = true}) {
  //   return state.urls.values.where((SavedUrl savedUrl) {
  //     return savedUrl.custom == custom;
  //   }).toList();
  // }

  // void deletetUrl(SavedUrl savedUrl) {
  //   appGlobals.store.actions.savedUrlActions.deleteUrl(savedUrl);
  // }
}
