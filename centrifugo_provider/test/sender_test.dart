import 'dart:async';

import 'package:centrifugo_provider/centrifugo_provider.dart';
import 'package:test/test.dart';

const int kBufferLimit = 2; // not change it!!!!
const Duration kConnectTimeout = Duration(seconds: 2);
const Duration kSendTimeout = Duration(milliseconds: 20);
final String kChannelName = 'channel1';

void main() {
  ChannelProvider _channelProvider;
  StreamSubscription _connectSubscription;

  tearDownAll(() {
    // _channelProvider.disconnect();
    _connectSubscription?.cancel();
  });

  group('[SENDER]', () {
    setUp(() async {
      _channelProvider = ChannelProvider(
          bufferLimit: kBufferLimit,
          url: 'ws://172.16.55.141:8001/connection/websocket?format=protobuf',
          sendTimeout: const Duration(milliseconds: 5));

      _connectSubscription = _channelProvider.connectedStream.listen((status) {
        // ignore: avoid_print
        // print('[SENDER] connect status: $status');
      });

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

      final bool createResult = _channelProvider.createSubscription(kChannelName);
      expect(createResult, isTrue);
    });

    tearDown(() {
      _connectSubscription?.cancel();
      _channelProvider.disconnect();
    });

    test('[SENDER] send null data', () async {
      final SendResult sendResult = await _channelProvider.send(kChannelName, 'action1', null);
      final bool sending = _channelProvider.sending;
      expect(sendResult, SendResult.ok);
      expect(sending, isFalse);
    });

    test('[SENDER] send very big data', () async {
      expect(_channelProvider.sending, isFalse);
      // not exists not null items in buffer is empty before sending
      final Iterable<DataBuffer> notNullItems = _channelProvider.dataBuffer.where((e) => e != null);
      expect(notNullItems.length, 0);

      final List<int> bigData = List.generate(10000, (index) => index);
      final SendResult sendResult = await _channelProvider.send(kChannelName, 'action_big_data', bigData);
      expect(sendResult, SendResult.timeException);
      expect(_channelProvider.sending, isFalse);

      // only lite data in buffer
      final Iterable<DataBuffer> notNullItems2 = _channelProvider.dataBuffer.where((e) => e != null);
      expect(notNullItems2.length, 1);
    });
  });
}
