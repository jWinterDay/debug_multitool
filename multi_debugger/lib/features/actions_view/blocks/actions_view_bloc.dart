import 'dart:async';

import 'package:multi_debugger/domain/base/base_bloc.dart';
import 'package:multi_debugger/domain/models/models.dart';
import 'package:multi_debugger/domain/states/server_event_state.dart';
import 'package:multi_debugger/domain/states/states.dart';
import 'package:rxdart/rxdart.dart';

class ActionsViewBloc extends BaseBloc {
  BehaviorSubject<List<ServerEvent>> _serverEventListSubject;
  Stream<List<ServerEvent>> get serverEventStateStream => _serverEventListSubject.stream;

  // event list stream
  StreamSubscription<List<ServerEvent>> _serverEventListSubscription;

  // title visible stream
  Stream<bool> get titleVisibleStream {
    return _serverEventListSubject.map((List<ServerEvent> eventList) {
      return eventList.isNotEmpty;
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

    _serverEventListSubject = BehaviorSubject<List<ServerEvent>>();

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

      List<ServerEvent> eventList = serverEventState.getEventsForChannel(currentChannel.channelId);

      return eventList;
    }).listen((List<ServerEvent> eventList) {
      _serverEventListSubject.add(eventList);
    });
  }
}
