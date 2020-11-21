import 'dart:async';

import 'package:centrifugo_provider/centrifugo_provider.dart';
import 'package:test/test.dart';

const int kBufferLimit = 2; // not change it!!!!
const Duration kConnectTimeout = Duration(seconds: 2);
const Duration kSendTimeoutShort = Duration(milliseconds: 2);
const Duration kSendTimeoutLong = Duration(milliseconds: 500);
final String kChannelName = 'channel1';

void main() {
  ChannelProvider _channelProvider;
  StreamSubscription _connectSubscription;

  tearDownAll(() {
    // _channelProvider.disconnect();
    _connectSubscription?.cancel();
  });

  group('[SENDER WITHOUT BUFFER]', () {
    setUp(() async {
      _channelProvider = ChannelProvider(
        bufferLimit: kBufferLimit,
        url: 'ws://172.16.55.141:8001/connection/websocket?format=protobuf',
        useBuffer: false,
      );

      _connectSubscription = _channelProvider.connectedStream.listen((status) {
        // ignore: avoid_print
        // print('[SENDER] connect status: $status');
      });

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

      final bool createResult = _channelProvider.createSubscription(kChannelName);
      expect(createResult, isTrue);
    });

    tearDown(() {
      _connectSubscription?.cancel();
      _channelProvider
        ..disconnect()
        ..clearBuffer();
    });

    test('send null data', () async {
      final SendResult sendResult = await _channelProvider.send(kChannelName, 'action1', null);
      final bool sending = _channelProvider.sending;
      expect(sendResult, SendResult.anotherException);
      expect(sending, isFalse);
    });

    test('send very big data timeout exception', () async {
      expect(_channelProvider.sending, isFalse);
      // not exists not null items in buffer is empty before sending
      final Iterable<DataBuffer> notNullItems = _channelProvider.dataBuffer.where((e) => e != null);
      expect(notNullItems.length, 0);

      final List<int> bigData = List.generate(100000, (index) => index);
      final SendResult sendResult = await _channelProvider.send(
        kChannelName,
        'action_big_data',
        bigData,
        sendTimeout: kSendTimeoutShort,
      );
      expect(sendResult, SendResult.timeException);
      expect(_channelProvider.sending, isFalse);

      // no data in buffer
      final Iterable<DataBuffer> notNullItems2 = _channelProvider.dataBuffer.where((e) => e != null);
      expect(notNullItems2.length, 0);
      expect(_channelProvider.sending, isFalse);
    });

    // test('send very big data another exception', () async {
    //   expect(_channelProvider.sending, isFalse);
    //   // not exists not null items in buffer is empty before sending
    //   final Iterable<DataBuffer> notNullItems = _channelProvider.dataBuffer.where((e) => e != null);
    //   expect(notNullItems.length, 0);

    //   final List<int> bigData = List.generate(100000, (index) => index);
    //   final SendResult sendResult = await _channelProvider.send(
    //     kChannelName,
    //     'action_big_data',
    //     bigData,
    //     sendTimeout: kSendTimeoutLong,
    //   );
    //   // expect(sendResult, SendResult.anotherException);
    //   // expect(_channelProvider.sending, isFalse);

    //   // // only lite data in buffer
    //   // final Iterable<DataBuffer> notNullItems2 = _channelProvider.dataBuffer.where((e) => e != null);
    //   // expect(notNullItems2.length, 0);
    //   // expect(_channelProvider.sending, isFalse);
    // });
  });
}
