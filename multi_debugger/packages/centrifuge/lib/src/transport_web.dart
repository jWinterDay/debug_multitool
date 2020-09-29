import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
//import 'dart:io';
import 'package:web_socket_channel/html.dart';

import 'package:meta/meta.dart';
import 'package:protobuf/protobuf.dart';

import 'codec.dart';
import 'error.dart' as centrifuge;
import 'proto/client.pb.dart' hide Error;

typedef Transport TransportBuilder({
  @required String url,
  @required TransportConfig config,
});

typedef Future<HtmlWebSocketChannel> HtmlWebSocketChannelBuilder();

class TransportConfig {
  TransportConfig({
    this.pingInterval = const Duration(seconds: 25),
    this.headers = const <String, dynamic>{},
  });

  final Duration pingInterval;
  final Map<String, dynamic> headers;
}

Transport protobufTransportBuilder({@required String url, @required TransportConfig config}) {
  final replyDecoder = ProtobufReplyDecoder();
  final commandEncoder = ProtobufCommandEncoder();

  final transport = Transport(
    () async => HtmlWebSocketChannel.connect(
      url,
      //headers: config.headers, pingInterval: config.pingInterval
    ),
    config,
    commandEncoder,
    replyDecoder,
  );

  return transport;
}

abstract class GeneratedMessageSender {
  Future<Rep> sendMessage<Req extends GeneratedMessage, Rep extends GeneratedMessage>(Req request, Rep result);
}

class Transport implements GeneratedMessageSender {
  Transport(this._socketBuilder, this._config, this._commandEncoder, this._replyDecoder);

  final HtmlWebSocketChannelBuilder _socketBuilder;
  HtmlWebSocketChannel _socket;
  final CommandEncoder _commandEncoder;
  final ReplyDecoder _replyDecoder;
  // ignore: unused_field
  final TransportConfig _config;

  Future open(void onPush(Push push), {Function onError, void onDone(String reason, bool shouldReconnect)}) async {
    _socket = await _socketBuilder();
    // if (_config.pingInterval != Duration.zero) {
    //   _socket.pingInterval = _config.pingInterval;
    // }

    _socket.stream.listen(
      _onData(onPush),
      onError: onError,
      onDone: _onDone(onDone),
    );
  }

  int _messageId = 1;

  final _completers = <int, Completer<GeneratedMessage>>{};

  @override
  Future<Rep> sendMessage<Req extends GeneratedMessage, Rep extends GeneratedMessage>(Req request, Rep result) async {
    final command = _createCommand(request);
    final reply = await _sendCommand(command);

    final filledResult = _processResult(result, reply);
    return filledResult;
  }

  Future close() {
    return _socket.sink.close();
  }

  Command _createCommand(GeneratedMessage request) => Command()
    ..id = _messageId++
    ..method = _getType(request)
    ..params = request.writeToBuffer();

  Future<Reply> _sendCommand(Command command) {
    final Completer<Reply> completer = Completer<Reply>.sync();

    _completers[command.id] = completer;

    final List<int> data = _commandEncoder.convert(command);

    if (_socket == null) {
      throw centrifuge.ClientDisconnectedError;
    }

    // _socket.sink.add(data);
    _socket.sink.add(Uint8List.fromList(data));

    return completer.future;
  }

  T _processResult<T extends GeneratedMessage>(T result, Reply reply) {
    if (reply.hasError()) {
      throw centrifuge.Error.custom(reply.error.code, reply.error.message);
    }
    result.mergeFromBuffer(reply.result);
    return result;
  }

  MethodType _getType(GeneratedMessage request) {
    switch (request.runtimeType) {
      case ConnectRequest:
        return MethodType.CONNECT;
      case PublishRequest:
        return MethodType.PUBLISH;
      case UnsubscribeRequest:
        return MethodType.UNSUBSCRIBE;
      case SubscribeRequest:
        return MethodType.SUBSCRIBE;
      case HistoryRequest:
        return MethodType.HISTORY;
      case RPCRequest:
        return MethodType.RPC;
      default:
        throw ArgumentError('unknown request type');
    }
  }

  Function _onDone(void Function(String, bool) onDone) {
    return () {
      String reason;
      bool reconnect = true;
      if (_socket.closeReason != null) {
        try {
          final Map<String, dynamic> info = jsonDecode(_socket.closeReason);
          reason = info['reason'];
          reconnect = info['reconnect'] ?? true;
        } catch (_) {}
      }
      onDone(reason, reconnect);
    };
  }

  Function _onData(void onPush(Push push)) {
    return (dynamic input) {
      final List<Reply> replies = _replyDecoder.convert(input);

      replies.forEach((reply) {
        if (reply.id > 0) {
          _completers.remove(reply.id).complete(reply);
        } else {
          final push = Push.fromBuffer(reply.result);

          onPush(push);
        }
      });
    };
  }
}
