import 'dart:async';
import 'dart:convert';

import 'package:debug_desktop_client/app_di.dart';
import 'package:debug_desktop_client/mobx/channel.dart';
import 'package:debug_desktop_client/mobx/connect_status.dart';
import 'package:debug_desktop_client/mobx/log.dart';
import 'package:debug_desktop_client/mobx/log_state.dart';
import 'package:debug_desktop_client/services/logger_service.dart';
import 'package:debug_desktop_client/services/service.dart';
import 'package:centrifuge/centrifuge.dart' as centrifuge;
import 'package:rxdart/rxdart.dart';

class CentrifugoService implements Service {
  CentrifugoService(this.channel);

  final Channel channel;

  final LoggerService _loggerService = di.get<LoggerService>();
  final BehaviorSubject<ConnectStatus> _connectStatusSubject = BehaviorSubject<ConnectStatus>();
  Stream<ConnectStatus> get connectStatusStream => _connectStatusSubject.stream;
  ConnectStatus get _currentConnectStatus => _connectStatusSubject.value;

  centrifuge.Client _client;
  centrifuge.Subscription _subscription;
  StreamSubscription<centrifuge.ConnectEvent> _connectSub;
  StreamSubscription<centrifuge.DisconnectEvent> _disconnectSub;
  StreamSubscription<centrifuge.PublishEvent> _publishSub;
  final JsonEncoder _encoder = const JsonEncoder.withIndent('   ');

  Log get _prevLog => channel.logStates.isEmpty ? null : channel.logStates.last.log;
  int get _logId => channel.logStates.length;

  @override
  Future<void> init() async {}

  @override
  Future<void> dispose() async {
    await _connectStatusSubject.close();
  }

  /// connect to centrifugo server
  void connect() {
    _connectStatusSubject.add(ConnectStatus.connecting);
    _client = centrifuge.createClient(channel.wsUrl);
    _subscription = _client.getSubscription(channel.name);

    // connect sub
    _connectSub = _client.connectStream.listen((centrifuge.ConnectEvent event) {
      _connectStatusSubject.add(ConnectStatus.connected);

      final Log log = Log(
        id: 'none',
        count: _logId,
        action: 'connect',
        actionPayload: 'client: ${event.client}, version: ${event.version}',
        prevLog: _prevLog,
        canSend: false,
        rawData: null,
        backAction: false,
      );

      channel.addLog(LogState(log));
    });

    // disconnect sub
    _disconnectSub = _client.disconnectStream.listen((centrifuge.DisconnectEvent event) {
      _connectStatusSubject.add(ConnectStatus.disconnected);

      final Log log = Log(
        id: 'none',
        count: _logId,
        action: 'disconnect',
        actionPayload: 'reason: ${event.reason}, shouldReconnect: ${event.shouldReconnect}',
        prevLog: _prevLog,
        canSend: false,
        rawData: null,
        backAction: false,
      );

      channel.addLog(LogState(log));
    });

    // publish sub
    _publishSub = _subscription.publishStream.listen((centrifuge.PublishEvent event) {
      final Map<String, dynamic> message = json.decode(utf8.decode(event.data)) as Map<String, dynamic>;

      String rawId;
      String prettyActionPayload = 'unknown action payload';
      String prettyState = 'unknown state';
      String action = 'unknown action';
      bool backAction = false;

      try {
        action = message['action']?.toString() ?? 'unknown action';
        final dynamic rawPayload = message['payload'];
        final dynamic rawState = message['state'];
        rawId = message['id'].toString();
        backAction = (message['back'] ?? false) as bool;

        prettyActionPayload = _encoder.convert(rawPayload);
        prettyState = _encoder.convert(rawState);
      } catch (exc) {
        _loggerService.e('publishStream. exc: $exc');
      }

      final Log log = Log(
        id: rawId,
        count: _logId,
        action: action,
        actionPayload: prettyActionPayload,
        state: prettyState,
        prevLog: _prevLog,
        rawData: event.data,
        backAction: backAction,
      );

      channel.addLog(LogState(log));
    });

    // connect
    _subscription.subscribe();
    _client.connect();
  }

  /// disconnect from centrifugo server
  void disconnect() {
    if (_currentConnectStatus == ConnectStatus.connected) {
      _client?.disconnect();
    }

    Future<void>.delayed(const Duration(milliseconds: 200), () {
      _connectSub?.cancel();
      _disconnectSub?.cancel();
      _publishSub?.cancel();
    });

    _subscription?.unsubscribe();
    _connectStatusSubject.add(ConnectStatus.disconnected);
    _client = null;
  }

  /// send custom data to centrifugo
  Future<void> _sendRawData(List<int> data) async {
    await _subscription.publish(data);
  }

  /// send log back to centrifugo
  Future<void> sendLogState(LogState logState) async {
    final Map<String, dynamic> dataMap = <String, dynamic>{
      'back': true,
      'action': logState.log.action,
      'id': logState.log.id,
    };

    final List<int> data = utf8.encode(jsonEncode(dataMap));

    await _sendRawData(data);
  }
}
