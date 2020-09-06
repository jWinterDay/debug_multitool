import 'dart:async';

import 'package:multi_debugger/domain/base/base_bloc.dart';
import 'package:multi_debugger/domain/states/states.dart';
import 'package:rxdart/rxdart.dart';

class EditTabBarBloc extends BaseBloc {
  StreamSubscription<AppConfigState> _computerNameSubscription;

  BehaviorSubject<String> _computerNameSubject;
  String get initComputerName => appGlobals.store.state.appConfigState.computerName;
  Stream<String> get computerNameStream => _computerNameSubject.stream;

  @override
  void dispose() {
    _computerNameSubscription?.cancel();
    _computerNameSubject.close();

    super.dispose();
  }

  @override
  void init() {
    super.init();

    _computerNameSubject = BehaviorSubject<String>();

    _computerNameSubscription = appGlobals.store.nextSubstate((AppState state) {
      return state;
    }).map((AppState state) {
      return state.appConfigState;
    }).listen((AppConfigState state) {
      _computerNameSubject.add(state.computerName);
    });
  }

  // ChannelModel channelModel = ChannelModel((b) {
  //   return b
  //     ..name = 'fsd'
  //     ..serverConnectStatus = ServerConnectStatus.disconnected
  //     ..isCurrent = false
  //     ..shortName = 'current';
  // });

  // appGlobals.store.actions.channelActions.addChannel(channelModel);
}
