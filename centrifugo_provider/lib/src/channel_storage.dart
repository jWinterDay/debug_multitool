import 'dart:async';
import 'dart:collection';

import 'package:centrifuge/centrifuge.dart' as centrifuge;
import 'package:centrifugo_provider/src/connect_status.dart';
import 'package:flutter/foundation.dart';
import 'package:rxdart/rxdart.dart';

import 'data_buffer.dart';

const int _kDefaultBufferLimit = 1000;
const Duration _kConnectTimeout = Duration(seconds: 10);

class ChannelProvider {
  ChannelProvider({
    this.bufferLimit = _kDefaultBufferLimit,
    @required this.url,
    this.connectTimeout = _kConnectTimeout,
    this.clientConfig,
  })  : assert(bufferLimit != null),
        assert(url != null),
        assert(_kConnectTimeout != null) {
    _dataBuffer = []..length = bufferLimit;
    _client = centrifuge.createClient(url, config: clientConfig);
  }

  final int bufferLimit;
  final String url;
  final Duration connectTimeout;
  final centrifuge.ClientConfig clientConfig;

  /// <channel name, subscription>
  final Map<String, centrifuge.Subscription> _subscriptionMap = {};
  Iterable<String> get channels => _subscriptionMap.keys;

  // common
  List<DataBuffer> _dataBuffer;
  UnmodifiableListView<DataBuffer> get dataBuffer => UnmodifiableListView(_dataBuffer);

  bool _sending = false;
  bool get sending => _sending;

  final BehaviorSubject<ConnectStatus> _connectedSubject =
      BehaviorSubject<ConnectStatus>.seeded(ConnectStatus.disconnected);
  Stream<ConnectStatus> get connectedStream => _connectedSubject.stream;
  ConnectStatus get connectStatus => _connectedSubject.value;

  Timer _connectTimer;

  // centrifugo
  centrifuge.Client _client;
  StreamSubscription _centrifugoConnectSubscription;
  StreamSubscription _centrifugoDisconnectSubscription;

  void clearBuffer() {
    _dataBuffer.clear();
  }

  bool connect() {
    if (connectStatus == ConnectStatus.connecting) {
      return false; //throw AlreadyInitializedException();
    }

    _connectedSubject.add(ConnectStatus.connecting);

    // connect timer
    _connectTimer = Timer(connectTimeout, () {
      _connectedSubject.add(ConnectStatus.disconnected);
    });

    _centrifugoConnectSubscription = _client.connectStream.listen((centrifuge.ConnectEvent event) {
      _connectedSubject.add(ConnectStatus.connected);

      // cancel connect timer
      final bool timerActive = _connectTimer?.isActive ?? false;
      if (timerActive) {
        _connectTimer?.cancel();
      }
    });

    _centrifugoDisconnectSubscription = _client.disconnectStream.listen((centrifuge.DisconnectEvent event) {
      _connectedSubject.add(ConnectStatus.disconnected);
    });

    _client.connect();

    return true;
  }

  void disconnect() {
    _sending = false;
    _connectedSubject.add(ConnectStatus.disconnected);

    _centrifugoConnectSubscription?.cancel();
    _centrifugoDisconnectSubscription?.cancel();

    if (connectStatus == ConnectStatus.connected) {
      _client?.disconnect();
    }

    _connectTimer?.cancel();
  }

  bool createSubscription(String channelName) {
    if (_client == null) {
      return false;
    }

    _subscriptionMap.putIfAbsent(
      channelName,
      () => _client.getSubscription(channelName),
    );

    _subscriptionMap[channelName].subscribe();

    return true;
  }

  bool send(String channelName, String action, List<int> utf8ListData) {
    if (_client == null) {
      return false;
    }

    if (connectStatus != ConnectStatus.connected) {
      // in range
      if (_dataBuffer.length > bufferLimit) {
        _dataBuffer.removeAt(0);
      }

      _dataBuffer.add(DataBuffer(
        action: action,
        channelName: channelName,
        utf8ListData: utf8ListData,
      ));

      return true;
    }

    // final centrifuge.Subscription subscription = _subscriptionMap[channelName];

    // if (_sending) {
    //   _dataBuffer.add(DataBuffer(
    //     action: action,
    //     channelName: channelName,
    //     utf8ListData: utf8ListData,
    //   ));
    //   return false;
    // }

    // _sending = true;
    // runZonedGuarded(() async {
    //   if (subscription == null) {
    //     return;
    //   }

    //   await subscription
    //       .publish(utf8ListData)
    //       .timeout(const Duration(seconds: 1))
    //       .catchError((dynamic error, StackTrace stackTrace) {
    //     final Map<String, dynamic> outputMap = <String, dynamic>{
    //       'action': action,
    //       'payload': 'Sending failed by timeout',
    //     };
    //     final List<int> timeoutData = utf8.encode(jsonEncode(outputMap));

    //     // send failed action
    //     _sending = false;
    //     send(
    //       channelName,
    //       action,
    //       timeoutData,
    //     );

    //     return;
    //   });

    //   _sending = false;

    //   if (_dataBuffer.isNotEmpty) {
    //     // recursively send all data
    //     // _DataBuffer dataBuffer = _dataBuffer.removeAt(0);
    //     // send(
    //     //   dataBuffer.channelName,
    //     //   dataBuffer.action,
    //     //   dataBuffer.utf8ListData,
    //     // );
    //   }
    // }, (error, stackTrace) async {
    //   // logger.e('CENTRIFUGO. Unexpected error: $error'); //\n$stackTrace', error.runtimeType, stackTrace);
    //   _sending = false;
    // });

    return true;
  }
}
