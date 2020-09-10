import 'dart:async';

import 'package:built_collection/built_collection.dart';
import 'package:multi_debugger/domain/base/base_bloc.dart';
import 'package:multi_debugger/domain/base/pair.dart';
import 'package:multi_debugger/domain/models/models.dart';
import 'package:multi_debugger/domain/states/server_event_state.dart';
import 'package:multi_debugger/domain/states/states.dart';
import 'package:rxdart/rxdart.dart';

class ActionsViewBloc extends BaseBloc {
  BehaviorSubject<Pair<ChannelModel, BuiltList<ServerEvent>>> _serverEventListSubject;
  Stream<Pair<ChannelModel, BuiltList<ServerEvent>>> get serverEventStateStream => _serverEventListSubject.stream;

  // event list stream
  StreamSubscription<Pair<ChannelModel, BuiltList<ServerEvent>>> _serverEventListSubscription;

  // title visible stream
  Stream<bool> get titleVisibleStream {
    return _serverEventListSubject.map((Pair<ChannelModel, BuiltList<ServerEvent>> pair) {
      final BuiltList<ServerEvent> list = pair.second;

      return list.isNotEmpty;
    });
  }

  @override
  void dispose() {
    _serverEventListSubscription?.cancel();
    _serverEventListSubject.close();

    super.dispose();
  }

  @override
  void init() {
    super.init();

    _serverEventListSubject = BehaviorSubject<Pair<ChannelModel, BuiltList<ServerEvent>>>();

    // combine server event stream
    Stream<ServerEventState> serverEventStateStream = appStateStream.map((AppState appState) {
      return appState.serverEventState;
    });

    // combine channel stream
    Stream<ChannelState> channelStateStream = appStateStream.map((AppState appState) {
      return appState.channelState;
    });

    _serverEventListSubscription = Rx.combineLatest2(serverEventStateStream, channelStateStream, (
      ServerEventState serverEventState,
      ChannelState channelState,
    ) {
      final ChannelModel currentChannel = channelState.currentChannel;
      if (currentChannel == null) {
        return null;
      }

      BuiltList<ServerEvent> eventList = serverEventState.getEventsForChannel(currentChannel);

      return Pair(currentChannel, eventList);
    })
        // .distinct((List<ServerEvent> prev, List<ServerEvent> next) {
        //   print('prev = ${prev.hashCode}, next = ${next.hashCode} eq = ${prev == next}');
        //   return (prev?.length ?? 0) == (next?.length ?? 0); // false; //prev == next;
        // })
        .listen((Pair<ChannelModel, BuiltList<ServerEvent>> pair) {
      _serverEventListSubject.add(pair);
    });
  }

  /// toggle favorite server event
  void toggleFavorite(ServerEvent serverEvent) {
    final ChannelModel currentChannelModel = appGlobals.store.state.channelState.currentChannel;

    Pair<String, ServerEvent> pair = Pair(currentChannelModel.channelId, serverEvent);

    appGlobals.store.actions.serverEventActions.toggleFavorite(pair);
  }

  /// toggle white list in current channel model
  void toggleWhiteList(ServerEvent serverEvent) {
    //
  }

  /// toggle black list in current channel model
  void toggleBlackList(ServerEvent serverEvent) {
    //
  }
}
