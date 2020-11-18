import 'dart:async';

import 'package:centrifuge/centrifuge.dart';
import 'package:centrifugo_provider/centrifugo_provider.dart';
import 'package:test/test.dart';

const int kBufferLimit = 10;

void main() {
  ChannelProvider _channelProvider;
  StreamSubscription _connectSubscription;

  tearDownAll(() {
    // _channelProvider.disconnect();
    _connectSubscription?.cancel();
  });

  group('[COMMON UNINITIALIZED]', () {
    setUpAll(() {
      _channelProvider = ChannelProvider(
        bufferLimit: kBufferLimit,
        url: '',
      );
    });

    tearDownAll(() {
      _channelProvider.disconnect();
    });

    test('[COMMON UNINITIALIZED] initialize', () {
      expect(_channelProvider.connectStatus, ConnectStatus.disconnected);
      expect(_channelProvider.sending, isFalse);
      expect(_channelProvider.channels, isEmpty);
      expect(_channelProvider.dataBufferLength, kBufferLimit);
    });

    test('[COMMON UNINITIALIZED] without initialize', () {
      expect(
        _channelProvider.send('name1', 'action1', null),
        isFalse,
      );
    });
  });

  group('[INCORRECT URL]', () {
    setUpAll(() {
      _channelProvider = ChannelProvider(
        bufferLimit: kBufferLimit,
        url: 'incorrect url',
      );

      _connectSubscription = _channelProvider.connectedStream.listen((status) {
        // ignore: avoid_print
        print('[INCORRECT URL] connect status: $status');
      });
    });

    tearDownAll(() {
      _connectSubscription?.cancel();
      _channelProvider.disconnect();
    });

    test('[INCORRECT] connect status', () async {
      _channelProvider.connect();

      await expectLater(
        _channelProvider.connectedStream,
        emitsInOrder(
          <ConnectStatus>[
            ConnectStatus.connecting,
            ConnectStatus.disconnected,
          ],
        ),
      );
    });
  });

  group('[CORRECT URL]', () {
    setUpAll(() {
      _channelProvider = ChannelProvider(
        bufferLimit: kBufferLimit,
        url: 'ws://172.16.55.141:8001/connection/websocket?format=protobuf',
      );

      _connectSubscription = _channelProvider.connectedStream.listen((status) {
        // ignore: avoid_print
        print('[CORRECT URL] connect status: $status');
      });
    });

    tearDownAll(() {
      _connectSubscription?.cancel();
      _channelProvider.disconnect();
    });

    test('[CORRECT URL] connect status', () async {
      _channelProvider.connect();

      await expectLater(
        _channelProvider.connectedStream,
        emitsInOrder(
          <ConnectStatus>[
            ConnectStatus.connecting,
            ConnectStatus.connected,
          ],
        ),
      );
    });
  });
}
