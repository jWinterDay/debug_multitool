import 'dart:async';

import 'package:built_collection/built_collection.dart';
import 'package:flutter/widgets.dart';
import 'package:multi_debugger/domain/base/base_bloc.dart';
import 'package:multi_debugger/domain/base/pair.dart';
import 'package:multi_debugger/domain/models/models.dart';
import 'package:multi_debugger/domain/states/server_event_state.dart';
import 'package:multi_debugger/domain/states/states.dart';
import 'package:rxdart/rxdart.dart';

class PayloadViewBloc extends BaseBloc {
  // final ScrollController scrollController = ScrollController();

  // BehaviorSubject<Pair<ChannelModel, BuiltList<ServerEvent>>> _serverEventListSubject;
  // Stream<Pair<ChannelModel, BuiltList<ServerEvent>>> get serverEventStateStream => _serverEventListSubject.stream;

  // // event list stream
  // StreamSubscription<Pair<ChannelModel, BuiltList<ServerEvent>>> _serverEventListSubscription;

  // // title visible stream
  // Stream<bool> get titleVisibleStream {
  //   return _serverEventListSubject.map((Pair<ChannelModel, BuiltList<ServerEvent>> pair) {
  //     final BuiltList<ServerEvent> list = pair.second;

  //     return list.isNotEmpty;
  //   });
  // }

  // bool inWhiteList(String actionName) => currentChannelModel.whiteList.contains(actionName);
  // bool inBlackList(String actionName) => currentChannelModel.blackList.contains(actionName);

  @override
  void dispose() {
    // _serverEventListSubscription?.cancel();
    // _serverEventListSubject.close();

    // scrollController.dispose();

    super.dispose();
  }

  @override
  void init() {
    super.init();

    // _serverEventListSubject = BehaviorSubject<Pair<ChannelModel, BuiltList<ServerEvent>>>();

    // // combine server event stream
    // Stream<ServerEventState> serverEventStateStream = appStateStream.map((AppState appState) {
    //   return appState.serverEventState;
    // });

    // // combine channel stream
    // Stream<ChannelState> channelStateStream = appStateStream.map((AppState appState) {
    //   return appState.channelState;
    // });

    // _serverEventListSubscription = Rx.combineLatest2(serverEventStateStream, channelStateStream, (
    //   ServerEventState serverEventState,
    //   ChannelState channelState,
    // ) {
    //   if (currentChannelModel == null) {
    //     return null;
    //   }

    //   BuiltList<ServerEvent> eventList = serverEventState.getEventsForChannel(currentChannelModel);

    //   return Pair(currentChannelModel, eventList);
    // }).distinct((prev, next) {
    //   // print('prev = ${prev.hashCode}, next = ${next.hashCode} eq = ${prev == next}');

    //   return prev == next;
    // }).listen((Pair<ChannelModel, BuiltList<ServerEvent>> pair) {
    //   _serverEventListSubject.add(pair);

    //   // scroll to end
    //   if (scrollController.hasClients && currentChannelModel.useAutoScroll) {
    //     Future.delayed(const Duration(milliseconds: 100), () {
    //       if (scrollController == null || !scrollController.hasClients) {
    //         return;
    //       }

    //       scrollController.animateTo(
    //         scrollController.position.maxScrollExtent,
    //         curve: Curves.easeOut,
    //         duration: const Duration(milliseconds: 200),
    //       );
    //     });
    //   }
    // });
  }

  /// add/remote to favorites in current channel model
  // void toggleFavorite(ServerEvent serverEvent) {
  //   Pair<String, ServerEvent> pair = Pair(currentChannelModel.channelId, serverEvent);

  //   appGlobals.store.actions.serverEventActions.toggleFavorite(pair);
  // }

  // /// add/remove to white list in current channel model
  // void toggleWhiteList(ServerEvent serverEvent) {
  //   final String actionName = serverEvent.action;
  //   final Pair<ChannelModel, String> pair = Pair(currentChannelModel, actionName);

  //   if (inWhiteList(actionName)) {
  //     appGlobals.store.actions.channelActions.deleteWhiteListItem(pair);
  //   } else {
  //     appGlobals.store.actions.channelActions.addWhiteListItem(pair);
  //   }
  // }

  // /// add/remove to black list in current channel model
  // void toggleBlackList(ServerEvent serverEvent) {
  //   final String actionName = serverEvent.action;
  //   final Pair<ChannelModel, String> pair = Pair(currentChannelModel, actionName);

  //   if (inBlackList(actionName)) {
  //     appGlobals.store.actions.channelActions.deleteBlackListItem(pair);
  //   } else {
  //     appGlobals.store.actions.channelActions.addBlackListItem(pair);
  //   }
  // }

  // void toggleSelectServerEvent(ServerEvent serverEvent) {
  //   final Pair<ChannelModel, ServerEvent> pair = Pair(currentChannelModel, serverEvent);

  //   appGlobals.store.actions.channelActions.selectEvent(pair);
  // }
}
