import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:multi_debugger/app_routes.dart';
import 'package:multi_debugger/domain/base/base_bloc.dart';
import 'package:multi_debugger/domain/base/pair.dart';
import 'package:multi_debugger/domain/enums/filter_list_type.dart';
import 'package:multi_debugger/domain/enums/server_event_type.dart';
import 'package:multi_debugger/domain/models/models.dart';
import 'package:multi_debugger/domain/states/states.dart';
import 'package:rxdart/subjects.dart';

class ChannelActionsBloc extends BaseBloc {
  StreamSubscription<ChannelState> _channelSubscription;

  BehaviorSubject<ChannelModel> _currentChannelModelSubject;
  Stream<ChannelModel> get currentChannelModelStream => _currentChannelModelSubject.stream;

  @override
  void dispose() {
    _channelSubscription?.cancel();
    _currentChannelModelSubject.close();

    super.dispose();
  }

  @override
  void init() {
    super.init();

    _currentChannelModelSubject = BehaviorSubject<ChannelModel>();

    _channelSubscription = appStateStream.map((AppState state) {
      return state.channelState;
    }).listen((ChannelState state) {
      final ChannelModel currentChannelModel = state.currentChannel;

      _currentChannelModelSubject.add(currentChannelModel);
    });
  }

  /// toggle show favorite server events
  void toggleUseFavorites(BuildContext context) {
    if (currentChannelModel == null) {
      return;
    }

    appGlobals.store.actions.channelActions.toggleShowFavorites(currentChannelModel);
  }

  /// toggle show white list
  void toggleUseWhiteList(BuildContext context) {
    if (currentChannelModel == null) {
      return;
    }

    appGlobals.store.actions.channelActions.toggleShowWhiteList(currentChannelModel);
  }

  /// toggle show white list
  void toggleUseBlackList(BuildContext context) {
    if (currentChannelModel == null) {
      return;
    }

    appGlobals.store.actions.channelActions.toggleShowBlackList(currentChannelModel);
  }

  /// show white list dialog
  void showWhiteList(BuildContext context) {
    if (currentChannelModel == null) {
      return;
    }

    appGlobals.store.actions.routeTo(
      AppRoute((builder) => builder
        ..route = AppRoutes.filterList
        ..bundle = FilterListType.white
        ..context = context),
    );
  }

  /// show black list dialog
  void showBlackList(BuildContext context) {
    if (currentChannelModel == null) {
      return;
    }

    appGlobals.store.actions.routeTo(
      AppRoute((builder) => builder
        ..route = AppRoutes.filterList
        ..bundle = FilterListType.black
        ..context = context),
    );
  }

  /// add divider
  void addDivider(BuildContext context) {
    if (currentChannelModel == null) {
      return;
    }

    // server event -> connect
    ServerEvent serverEvent = ServerEvent((b) {
      b
        ..action = ''
        ..serverEventType = ServerEventType.delimiter;

      return b;
    });

    Pair<String, ServerEvent> event = Pair(currentChannelModel.channelId, serverEvent);
    appGlobals.store.actions.serverEventActions.addEvent(event);
  }

  /// use autoscroll
  void useAutoScroll(BuildContext context) {
    if (currentChannelModel == null) {
      return;
    }

    appGlobals.store.actions.channelActions.toggleAutoScroll(currentChannelModel);
  }

  /// clear all
  void clearAll(BuildContext context) {
    if (currentChannelModel == null) {
      return;
    }

    appGlobals.store.actions.serverEventActions.clearEvents(currentChannelModel);
  }
}
