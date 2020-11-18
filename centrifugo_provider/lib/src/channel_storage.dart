import 'dart:async';
import 'dart:convert';

import 'package:centrifuge/centrifuge.dart' as centrifuge;
import 'package:centrifugo_provider/src/connect_status.dart';
import 'package:flutter/foundation.dart';
import 'package:rxdart/rxdart.dart';

import 'data_buffer.dart';

const int _kDefaultBufferLimit = 1000;
const Duration _kConnectTimeout = Duration(seconds: 1);

class ChannelProvider {
  ChannelProvider({
    this.bufferLimit = _kDefaultBufferLimit,
    @required this.url,
  })  : assert(bufferLimit != null),
        assert(url != null) {
    _dataBuffer = List(bufferLimit);
  }

  final int bufferLimit;
  final String url;

  /// <channel name, subscription>
  final Map<String, centrifuge.Subscription> _subscriptionMap = {};
  Iterable<String> get channels => _subscriptionMap.keys;

  // common
  List<DataBuffer> _dataBuffer;
  bool _sending = false;
  int get dataBufferLength => _dataBuffer.length;
  bool get sending => _sending;

  final BehaviorSubject<ConnectStatus> _connectedSubject =
      BehaviorSubject<ConnectStatus>.seeded(ConnectStatus.disconnected);
  Stream<ConnectStatus> get connectedStream => _connectedSubject.stream;
  ConnectStatus get connectStatus => _connectedSubject.value;

  // centrifugo
  centrifuge.Client _client;
  StreamSubscription _centrifugoConnectSubscription;
  StreamSubscription _centrifugoDisconnectSubscription;

  bool connect([centrifuge.ClientConfig clientConfig]) {
    if (connectStatus == ConnectStatus.connecting) {
      return false; //throw AlreadyInitializedException();
    }

    _connectedSubject.add(ConnectStatus.connecting);

    _client = centrifuge.createClient(url, config: clientConfig);

    _centrifugoConnectSubscription = _client.connectStream.listen((centrifuge.ConnectEvent event) {
      _connectedSubject.add(ConnectStatus.connected);
    });
    _centrifugoDisconnectSubscription = _client.disconnectStream.listen((centrifuge.DisconnectEvent event) {
      _connectedSubject.add(ConnectStatus.disconnected);
    });

    _client.connect();

    return true;
  }

  void disconnect() {
    _connectedSubject?.close();
    _centrifugoConnectSubscription?.cancel();
    _centrifugoDisconnectSubscription?.cancel();

    if (connectStatus == ConnectStatus.connected) {
      _client?.disconnect();
    }
  }

  void createSubscription(String channelName) {
    _subscriptionMap.putIfAbsent(
      channelName,
      () => _client.getSubscription(channelName),
    );

    _subscriptionMap[channelName].subscribe();
  }

  bool send(String channelName, String action, List<int> utf8ListData) {
    if (connectStatus != ConnectStatus.connected) {
      // ignore: avoid_print
      // print('-----CentrifugoProvider not connected. _dataBuffer.length = ${_dataBuffer.length} action: $action');
      return false;
    }

    final centrifuge.Subscription subscription = _subscriptionMap[channelName];

    if (_sending) {
      _dataBuffer.add(DataBuffer(
        action: action,
        channelName: channelName,
        utf8ListData: utf8ListData,
      ));
      return false;
    }

    _sending = true;
    runZonedGuarded(() async {
      if (subscription == null) {
        return;
      }

      await subscription
          .publish(utf8ListData)
          .timeout(const Duration(seconds: 1))
          .catchError((dynamic error, StackTrace stackTrace) {
        final Map<String, dynamic> outputMap = <String, dynamic>{
          'action': action,
          'payload': 'Sending failed by timeout',
        };
        final List<int> timeoutData = utf8.encode(jsonEncode(outputMap));

        // send failed action
        _sending = false;
        send(
          channelName,
          action,
          timeoutData,
        );

        return;
      });

      _sending = false;

      if (_dataBuffer.isNotEmpty) {
        // recursively send all data
        // _DataBuffer dataBuffer = _dataBuffer.removeAt(0);
        // send(
        //   dataBuffer.channelName,
        //   dataBuffer.action,
        //   dataBuffer.utf8ListData,
        // );
      }
    }, (error, stackTrace) async {
      // logger.e('CENTRIFUGO. Unexpected error: $error'); //\n$stackTrace', error.runtimeType, stackTrace);
      _sending = false;
    });

    return true;
  }
}
