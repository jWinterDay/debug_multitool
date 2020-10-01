import 'dart:async';

import 'package:json_diff/json_diff.dart';
import 'package:multi_debugger/domain/base/base_bloc.dart';
import 'package:multi_debugger/domain/enums/payload_view_type.dart';
import 'package:multi_debugger/domain/models/models.dart';
import 'package:multi_debugger/domain/states/server_event_state.dart';
import 'package:multi_debugger/domain/states/states.dart';
import 'package:rxdart/rxdart.dart';
import 'package:multi_debugger/tools/common_tools.dart' as common_tools;

class PayloadViewBloc extends BaseBloc {
  BehaviorSubject<PayloadViewType> _payloadViewTypeSubject;
  Stream<PayloadViewType> get payloadViewTypeStream => _payloadViewTypeSubject.stream;

  BehaviorSubject<ServerEvent> _selectedEventSubject;
  Stream<ServerEvent> get selectedEventStream => _selectedEventSubject.stream;

  StreamSubscription<ChannelState> _channelStateSubscription;

  @override
  void dispose() {
    _channelStateSubscription?.cancel();

    _payloadViewTypeSubject.close();
    _selectedEventSubject.close();

    super.dispose();
  }

  @override
  void init() {
    super.init();

    _payloadViewTypeSubject = BehaviorSubject<PayloadViewType>();
    _selectedEventSubject = BehaviorSubject<ServerEvent>();

    _channelStateSubscription = appStateStream.map((AppState state) {
      return state.channelState;
    }).listen((ChannelState state) {
      final ServerEvent selectedEvent = state.currentChannel?.selectedEvent;

      _selectedEventSubject.add(selectedEvent);
    });
  }

  void selectTabBar(PayloadViewType payloadViewType) {
    _payloadViewTypeSubject.add(payloadViewType);
  }

  DiffNode getDiffNode(ServerEvent selectedEvent) {
    final ServerEventState channelState = appGlobals.store.state.serverEventState;
    final String channelId = appGlobals.store.state.channelState.currentChannel.channelId;

    final ServerEvent cur = _selectedEventSubject.value;
    final ServerEvent prev = channelState.getPrevServerEvent(selectedEvent.index, channelId);

    if (prev == null || (cur?.state == null && prev?.state == null)) {
      return null;
    }

    return common_tools.getDiff(prev, cur);
  }
}
