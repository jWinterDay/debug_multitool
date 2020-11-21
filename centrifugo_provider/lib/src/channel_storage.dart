import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'dart:isolate';

import 'package:centrifuge/centrifuge.dart' as centrifuge;
import 'package:centrifugo_provider/centrifugo_provider.dart';
import 'package:centrifugo_provider/src/connect_status.dart';
import 'package:flutter/foundation.dart';
import 'package:rxdart/rxdart.dart';

import 'data_buffer.dart';

const int _kDefaultBufferLimit = 1000;
const Duration _kDefaultConnectTimeout = Duration(seconds: 10);
const Duration _kDefaultSendTimeout = Duration(seconds: 1);
const String _kTimeoutExceptionMessage = 'Failed by timeout';

class ChannelProvider {
  ChannelProvider({
    this.bufferLimit = _kDefaultBufferLimit,
    @required this.url,
    this.connectTimeout = _kDefaultConnectTimeout,
    this.clientConfig,
    this.useBuffer = true,
  })  : assert(bufferLimit != null),
        assert(url != null),
        assert(_kDefaultConnectTimeout != null) {
    _dataBuffer = []..length = bufferLimit;
    _client = centrifuge.createClient(url, config: clientConfig);
  }

  /// main entry point
  // Future<ChannelProvider> init({
  //   int bufferLimit,
  //   @required String url,
  //   Duration connectTimeout,
  //   centrifuge.ClientConfig clientConfig,
  //   bool useBuffer = true,
  // }) async {
  //   _receivePort = ReceivePort();
  //   _mainIsolate = await Isolate.spawn(gfg, _receivePort.sendPort);

  //   return ChannelProvider._(
  //     bufferLimit: bufferLimit,
  //     url: url,
  //     connectTimeout: connectTimeout,
  //     clientConfig: clientConfig,
  //     useBuffer: useBuffer,
  //   );
  // }

  final int bufferLimit;
  final String url;
  final Duration connectTimeout;
  // final Duration sendTimeout;
  final centrifuge.ClientConfig clientConfig;
  final bool useBuffer;

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

  // isolate
  Isolate _mainIsolate;
  ReceivePort _receivePort;
  SendPort _sendPort;

  void clearBuffer() {
    _dataBuffer.clear();
  }

  static void gfg(SendPort sendPort) {
    int counter = 0;

    // Printing Output message after every 2 sec.
    Timer.periodic(new Duration(seconds: 2), (Timer t) {
      // Increasing the counter
      print('-----timer $counter');
      counter++;

      //Printing the output message
      // stdout.writeln('Welcome to GeeksForGeeks $counter');
    });
  }

  Future<bool> connect() async {
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

    _receivePort = ReceivePort();
    _mainIsolate = await Isolate.spawn(gfg, _receivePort.sendPort);

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

    _mainIsolate?.kill(priority: Isolate.immediate);
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

  void _addToBuffer(String channelName, String action, List<int> utf8ListData) {
    if (!useBuffer) {
      return;
    }

    // in range
    if (_dataBuffer.length > bufferLimit) {
      _dataBuffer.removeAt(0);
    }

    _dataBuffer.add(DataBuffer(
      action: action,
      channelName: channelName,
      utf8ListData: utf8ListData,
    ));
  }

  /// custom data for sending
  List<int> _getLiteData(String action, String message) {
    final Map<String, dynamic> outputMap = <String, dynamic>{
      'action': action,
      'payload': message,
    };
    final List<int> timeoutData = utf8.encode(jsonEncode(outputMap));

    return timeoutData;
  }

  Future<SendResult> send(
    String channelName,
    String action,
    List<int> utf8ListData, {
    Duration sendTimeout = _kDefaultSendTimeout,
  }) async {
    if (_client == null) {
      return SendResult.clientIsNull;
    }

    if (connectStatus != ConnectStatus.connected) {
      _addToBuffer(channelName, action, utf8ListData);

      return SendResult.notConnected;
    }

    final centrifuge.Subscription subscription = _subscriptionMap[channelName];

    if (_sending) {
      _addToBuffer(channelName, action, utf8ListData);
      return SendResult.anotherDataIsSending;
    }

    _sending = true;

    try {
      await subscription.publish(utf8ListData).timeout(sendTimeout);
    } catch (error) {
      _sending = false;
      // resend lite data on timeout exception
      // replace big data with lite message
      if (error is TimeoutException) {
        final List<int> liteMessage = _getLiteData(action, _kTimeoutExceptionMessage);

        _addToBuffer(channelName, action, liteMessage);

        return SendResult.timeException;
      }

      // ignore: avoid_print
      print('send error for action: $action: $error');

      return SendResult.anotherException;
    }

    // runZonedGuarded(() async {
    //   await subscription.publish(utf8ListData).timeout(sendTimeout);
    // }, (error, stackTrace) {
    //   // if (error is TimeoutException) {
    //   //   print('failed by timeout action: $action');
    //   //   return false;
    //   // }

    //   print('===========error = $error');
    //   return true;
    // });

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

    return SendResult.ok;
  }
}
