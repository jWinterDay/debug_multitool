import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'server_event_type.g.dart';

class ServerEventType extends EnumClass {
  const ServerEventType._(String name) : super(name);

  static const ServerEventType connect = _$connect;

  static const ServerEventType disconnect = _$disconnect;

  static const ServerEventType action = _$action;

  static const ServerEventType delimiter = _$delimiter;

  static const ServerEventType formatError = _$formatError;

  static const ServerEventType controlCommand = _$controlCommand;

  static const ServerEventType errorControlCommand = _$errorControlCommand;

  static BuiltSet<ServerEventType> get values => _$values;

  static ServerEventType valueOf(String name) => _$serverEventTypeValueOf(name);

  static Serializer<ServerEventType> get serializer => _$serverEventTypeSerializer;
}
