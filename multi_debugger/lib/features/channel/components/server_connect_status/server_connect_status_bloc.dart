import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:multi_debugger/domain/base/base_bloc.dart';
import 'package:multi_debugger/domain/models/models.dart';
import 'package:multi_debugger/domain/states/server_event_state.dart';
import 'package:multi_debugger/domain/states/states.dart';
import 'package:rxdart/subjects.dart';

class ConnectStatusBloc extends BaseBloc {
  ConnectStatusBloc({
    @required this.widgetChannelModel,
  }) : assert(widgetChannelModel != null);

  final ChannelModel widgetChannelModel;

  StreamSubscription<ServerEventState> _serverEventSubscription;
  StreamSubscription<ChannelState> _channelSubscription;

  int _unreadEventsCount = 0;

  BehaviorSubject<int> _unreadEventCountSubject;
  Stream<int> get unreadEventsCountStream => _unreadEventCountSubject.stream.distinct();

  @override
  void dispose() {
    _channelSubscription?.cancel();
    _serverEventSubscription?.cancel();

    _unreadEventCountSubject.close();

    super.dispose();
  }

  @override
  void init() {
    super.init();

    _unreadEventCountSubject = BehaviorSubject<int>.seeded(0);

    // change event state
    appGlobals.store.nextSubstate((AppState state) {
      return state.serverEventState;
    }).listen((ServerEventState state) {
      final bool eventInCurrentChannel = state.channelIdForLastEvent == widgetChannelModel.channelId;
      final bool currentChannelIsTheSame = currentChannelModel?.channelId == widgetChannelModel.channelId;

      if (eventInCurrentChannel && !currentChannelIsTheSame) {
        _unreadEventsCount++;

        final bool closed = _unreadEventCountSubject?.isClosed ?? true;
        if (!closed) {
          _unreadEventCountSubject.add(_unreadEventsCount);
        }
      }
    });

    // change current channel
    _channelSubscription = appGlobals.store.nextSubstate((AppState state) {
      return state.channelState;
    }).listen((ChannelState state) {
      if (widgetChannelModel.channelId == currentChannelModel?.channelId) {
        _unreadEventsCount = 0;
        _unreadEventCountSubject.add(_unreadEventsCount);
      }
    });
  }
}
