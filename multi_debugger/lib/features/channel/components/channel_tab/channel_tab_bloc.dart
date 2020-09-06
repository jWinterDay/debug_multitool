import 'dart:async';

import 'package:multi_debugger/domain/base/base_bloc.dart';
import 'package:multi_debugger/domain/models/models.dart';
import 'package:multi_debugger/domain/states/states.dart';
import 'package:rxdart/subjects.dart';

class ChannelTabBloc extends BaseBloc {
  StreamSubscription _channelSubscription;

  BehaviorSubject<ChannelState> _channelStateSubject;
  Stream<ChannelState> get channelState => _channelStateSubject.stream;

  @override
  void dispose() {
    _channelSubscription?.cancel();

    super.dispose();
  }

  @override
  void init() {
    super.init();

    _channelStateSubject = BehaviorSubject<ChannelState>();

    _channelSubscription = appGlobals.store.nextSubstate((state) {
      return state;
    }).map((state) {
      return state.channelState;
    }).listen((ChannelState state) {
      _channelStateSubject.add(state);
    });
  }

  void addNew() {
    ChannelModel channelModel = ChannelModel((b) {
      return b
        ..name = 'fsd'
        ..serverConnectStatus = ServerConnectStatus.disconnected
        ..isCurrent = false
        ..shortName = 'current';
    });

    appGlobals.store.actions.channelActions.addChannel(channelModel);
  }

  void updateChannel(ChannelModel channelModel) {
    //
  }
}
