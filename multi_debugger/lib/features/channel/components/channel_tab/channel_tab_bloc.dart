import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:multi_debugger/app_routes.dart';
import 'package:multi_debugger/domain/base/base_bloc.dart';
import 'package:multi_debugger/domain/models/models.dart';
import 'package:multi_debugger/domain/states/states.dart';
import 'package:rxdart/subjects.dart';

class ChannelTabBloc extends BaseBloc {
  StreamSubscription<ChannelState> _channelSubscription;

  BehaviorSubject<ChannelState> _channelStateSubject;
  Stream<ChannelState> get channelStateStream => _channelStateSubject.stream;

  @override
  void dispose() {
    _channelSubscription?.cancel();
    _channelStateSubject.close();

    super.dispose();
  }

  @override
  void init() {
    super.init();

    _channelStateSubject = BehaviorSubject<ChannelState>();

    _channelSubscription = appStateStream.map((AppState state) {
      return state.channelState;
    }).listen((ChannelState state) {
      _channelStateSubject.add(state);
    });
  }

  void showAddChannel(BuildContext context) {
    appGlobals.store.actions.routeTo(
      AppRoute((builder) => builder
        ..route = AppRoutes.editChannel
        ..context = context),
    );
  }

  void setCurrent(ChannelModel channelModel) {
    appGlobals.store.actions.channelActions.setCurrentChannel(channelModel);
    // appGlobals.store.actions.routeTo(
    //   AppRoute((builder) => builder
    //     ..route = AppRoutes.editChannel
    //     ..context = context
    //     ..bundle = channelModel),
    // );
  }
}
