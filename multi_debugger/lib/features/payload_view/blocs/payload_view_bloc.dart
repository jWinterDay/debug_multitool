import 'dart:async';

import 'package:multi_debugger/domain/base/base_bloc.dart';
import 'package:multi_debugger/domain/enums/payload_view_type.dart';
import 'package:multi_debugger/domain/models/models.dart';
import 'package:multi_debugger/domain/states/states.dart';
import 'package:rxdart/rxdart.dart';

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
      final ServerEvent selectdEvent = state.currentChannel?.selectedEvent;

      _selectedEventSubject.add(selectdEvent);
    });
  }

  void selectTabBar(PayloadViewType payloadViewType) {
    _payloadViewTypeSubject.add(payloadViewType);
  }
}
