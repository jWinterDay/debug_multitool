import 'dart:async';

import 'package:centrifugo_provider/centrifugo_provider.dart';
import 'package:test/test.dart';

const int kBufferLimit = 2; // not change it!!!!
const Duration kConnectTimeout = Duration(seconds: 2);

void main() {
  ChannelProvider _channelProvider;
  StreamSubscription _connectSubscription;

  tearDownAll(() {
    // _channelProvider.disconnect();
    _connectSubscription?.cancel();
  });

  group('[STORAGE BUFFER]', () {
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

    test('[STORAGE BUFFER] createSubscription, send without connect()', () async {
      final String channelName = 'channel1';

      final bool createResult = _channelProvider.createSubscription(channelName);
      expect(createResult, isTrue);

      final SendResult sendResult = await _channelProvider.send(channelName, 'action1', null);
      expect(sendResult, SendResult.notConnected);

      // check 1 not null item in buffer
      final Iterable<DataBuffer> notNullItems = _channelProvider.dataBuffer.where((e) => e != null);
      expect(notNullItems.length, 1);

      // check 0 items after clearing
      _channelProvider.clearBuffer();
      expect(_channelProvider.dataBuffer.length, 0);
    });

    /// circle buffer
    /// the oldest item will be removed, the newest will be inserted
    test('[STORAGE BUFFER] circle buffer', () async {
      final String channelName = 'channel1';

      expect(_channelProvider.sending, isFalse);

      for (int i = 0; i <= kBufferLimit; i++) {
        await _channelProvider.send(channelName, 'action_$i', null);
      }

      // check by action name
      final List<String> actionList = _channelProvider.dataBuffer.map((DataBuffer data) {
        return data.action;
      }).toList();

      expect(actionList, orderedEquals(<String>['action_0', 'action_1', 'action_2']));

      // more than limit
      await _channelProvider.send(channelName, 'action_3', null);
      final List<String> actionList2 = _channelProvider.dataBuffer.map((DataBuffer data) {
        return data.action;
      }).toList();

      expect(actionList2, orderedEquals(<String>['action_1', 'action_2', 'action_3']));
    });
  });
}
