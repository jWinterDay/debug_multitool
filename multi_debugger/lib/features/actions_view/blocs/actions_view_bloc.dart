import 'dart:async';

import 'package:built_collection/built_collection.dart';
import 'package:flutter/widgets.dart';
import 'package:multi_debugger/domain/base/base_bloc.dart';
import 'package:multi_debugger/domain/base/pair.dart';
import 'package:multi_debugger/domain/models/models.dart';
import 'package:multi_debugger/domain/states/server_event_state.dart';
import 'package:multi_debugger/domain/states/states.dart';
import 'package:rxdart/rxdart.dart';

const double kActionsItemExtent = 42.0;

class ActionsViewBloc extends BaseBloc {
  final ScrollController scrollController = ScrollController();

  BehaviorSubject<Pair<ChannelModel, BuiltList<ServerEvent>>> _serverEventListSubject;
  Stream<Pair<ChannelModel, BuiltList<ServerEvent>>> get serverEventStateStream => _serverEventListSubject.stream;

  // event list stream
  StreamSubscription<Pair<ChannelModel, BuiltList<ServerEvent>>> _eventPairSubscription;
  StreamSubscription<BuiltList<ServerEvent>> _serverEventListSubscription;

  // title visible stream
  Stream<bool> get titleVisibleStream {
    return _serverEventListSubject.map((Pair<ChannelModel, BuiltList<ServerEvent>> pair) {
      final BuiltList<ServerEvent> list = pair.second;

      return list.isNotEmpty;
    });
  }

  bool inWhiteList(String actionName) => currentChannelModel.whiteList.contains(actionName);
  bool inBlackList(String actionName) => currentChannelModel.blackList.contains(actionName);

  @override
  void dispose() {
    _eventPairSubscription?.cancel();
    _serverEventListSubscription?.cancel();
    _serverEventListSubject.close();

    scrollController.dispose();

    super.dispose();
  }

  @override
  void init() {
    super.init();

    _serverEventListSubject = BehaviorSubject<Pair<ChannelModel, BuiltList<ServerEvent>>>();

    // combine server event stream
    Stream<ServerEventState> serverEventStateStream = appGlobals.store.nextSubstate((AppState appState) {
      return appState.serverEventState;
    });

    // combine channel stream
    Stream<ChannelState> channelStateStream = appGlobals.store.nextSubstate((AppState appState) {
      return appState.channelState;
    });

    // stream mappers. scroll to end
    _serverEventListSubscription = serverEventStateStream.distinct((prevState, nextState) {
      final prevList = prevState.events[currentChannelModel.channelId];
      final nextList = nextState.events[currentChannelModel.channelId];

      return prevList?.length == nextList?.length;
    }).map((ServerEventState serverEventState) {
      return serverEventState.getEventsForChannel(currentChannelModel);
    }).listen((BuiltList<ServerEvent> list) {
      if (currentChannelModel == null) {
        return;
      }

      if (scrollController.hasClients && currentChannelModel.useAutoScroll) {
        if (scrollController == null || !scrollController.hasClients) {
          return;
        }

        Timer(const Duration(milliseconds: 100), () {
          if (scrollController == null || !scrollController.hasClients) {
            return;
          }

          scrollController?.animateTo(
            kActionsItemExtent * list.length,
            curve: Curves.easeOut,
            duration: const Duration(milliseconds: 150),
          );
        });
      }
    });

    // stream mappers. actions state
    _eventPairSubscription = Rx.combineLatest2(serverEventStateStream, channelStateStream, (
      ServerEventState serverEventState,
      ChannelState channelState,
    ) {
      if (currentChannelModel == null) {
        return null;
      }

      final BuiltList<ServerEvent> serverEventList = serverEventState.getEventsForChannel(currentChannelModel);

      return Pair(currentChannelModel, serverEventList);
    }).listen((Pair<ChannelModel, BuiltList<ServerEvent>> pair) {
      _serverEventListSubject.add(pair);
    });
  }

  /// add/remote to favorites in current channel model
  void toggleFavorite(ServerEvent serverEvent) {
    Pair<String, ServerEvent> pair = Pair(currentChannelModel.channelId, serverEvent);

    appGlobals.store.actions.serverEventActions.toggleFavorite(pair);
  }

  /// add/remove to white list in current channel model
  void toggleWhiteList(ServerEvent serverEvent) {
    final String actionName = serverEvent.action;
    final Pair<ChannelModel, String> pair = Pair(currentChannelModel, actionName);

    if (inWhiteList(actionName)) {
      appGlobals.store.actions.channelActions.deleteWhiteListItem(pair);
    } else {
      appGlobals.store.actions.channelActions.addWhiteListItem(pair);
    }
  }

  /// add/remove to black list in current channel model
  void toggleBlackList(ServerEvent serverEvent) {
    final String actionName = serverEvent.action;
    final Pair<ChannelModel, String> pair = Pair(currentChannelModel, actionName);

    if (inBlackList(actionName)) {
      appGlobals.store.actions.channelActions.deleteBlackListItem(pair);
    } else {
      appGlobals.store.actions.channelActions.addBlackListItem(pair);
    }
  }

  void toggleSelectServerEvent(ServerEvent serverEvent) {
    final Pair<ChannelModel, ServerEvent> pair = Pair(currentChannelModel, serverEvent);

    appGlobals.store.actions.channelActions.selectEvent(pair);
  }
}
