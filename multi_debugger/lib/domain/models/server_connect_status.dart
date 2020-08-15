import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'server_connect_status.g.dart';

/// Тип линии
class ServerConnectStatus extends EnumClass {
  const ServerConnectStatus._(String name) : super(name);

  static const ServerConnectStatus connected = _$connected;

  static const ServerConnectStatus disconnected = _$disconnected;

  static const ServerConnectStatus connecting = _$connecting;

  static BuiltSet<ServerConnectStatus> get values => _$values;

  static ServerConnectStatus valueOf(String name) => _$serverConnectStatusValueOf(name);

  static Serializer<ServerConnectStatus> get serializer => _$serverConnectStatusSerializer;
}
