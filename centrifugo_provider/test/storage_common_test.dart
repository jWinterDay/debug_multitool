import 'dart:async';

import 'package:centrifugo_provider/centrifugo_provider.dart';
import 'package:test/test.dart';

const int kBufferLimit = 10;
const Duration kConnectTimeout = Duration(seconds: 2);

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

    test('initialize', () {
      expect(_channelProvider.connectStatus, ConnectStatus.disconnected);
      expect(_channelProvider.sending, isFalse);
      expect(_channelProvider.channels, isEmpty);
    });

    // test('[COMMON UNINITIALIZED] without initialize', () {
    //   expect(
    //     _channelProvider.send('name1', 'action1', null),
    //     isFalse,
    //   );
    // });
  });

  group('[INCORRECT URL]', () {
    setUpAll(() {
      _channelProvider = ChannelProvider(
        bufferLimit: kBufferLimit,
        url: 'incorrect url',
        connectTimeout: kConnectTimeout,
      );

      _connectSubscription = _channelProvider.connectedStream.listen((status) {
        // ignore: avoid_print
        // print('[INCORRECT URL] connect status: $status');
      });
    });

    tearDownAll(() {
      _connectSubscription?.cancel();
      _channelProvider.disconnect();
    });

    test('connect status', () async {
      await _channelProvider.connect();

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
        // print('[CORRECT URL] connect status: $status');
      });
    });

    tearDownAll(() {
      _connectSubscription?.cancel();
      _channelProvider.disconnect();
    });

    test('connect status', () async {
      await _channelProvider.connect();

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

  group('[MANUAL DISCONNECTING]', () {
    setUpAll(() {
      _channelProvider = ChannelProvider(
        bufferLimit: kBufferLimit,
        url: 'ws://172.16.55.141:8001/connection/websocket?format=protobuf',
      );

      _connectSubscription = _channelProvider.connectedStream.listen((status) {
        // ignore: avoid_print
        print('[MANUAL DISCONNECTING] connect status: $status');
      });
    });

    tearDownAll(() {
      _connectSubscription?.cancel();
      _channelProvider.disconnect();
    });

    test('connect status', () async {
      await _channelProvider.connect();

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

    test('disconnect status', () async {
      _channelProvider.disconnect();

      await expectLater(
        _channelProvider.connectedStream,
        emitsInOrder(
          <ConnectStatus>[
            ConnectStatus.disconnected,
          ],
        ),
      );

      expect(_channelProvider.sending, isFalse);
    });

    test('restoring after disconnect', () async {
      await _channelProvider.connect();

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
