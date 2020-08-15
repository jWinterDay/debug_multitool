// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'server_connect_status.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const ServerConnectStatus _$connected = const ServerConnectStatus._('connected');
const ServerConnectStatus _$disconnected = const ServerConnectStatus._('disconnected');
const ServerConnectStatus _$connecting = const ServerConnectStatus._('connecting');

ServerConnectStatus _$serverConnectStatusValueOf(String name) {
  switch (name) {
    case 'connected':
      return _$connected;
    case 'disconnected':
      return _$disconnected;
    case 'connecting':
      return _$connecting;
    default:
      throw new ArgumentError(name);
  }
}

final BuiltSet<ServerConnectStatus> _$values = new BuiltSet<ServerConnectStatus>(const <ServerConnectStatus>[
  _$connected,
  _$disconnected,
  _$connecting,
]);

Serializer<ServerConnectStatus> _$serverConnectStatusSerializer = new _$ServerConnectStatusSerializer();

class _$ServerConnectStatusSerializer implements PrimitiveSerializer<ServerConnectStatus> {
  @override
  final Iterable<Type> types = const <Type>[ServerConnectStatus];
  @override
  final String wireName = 'ServerConnectStatus';

  @override
  Object serialize(Serializers serializers, ServerConnectStatus object,
          {FullType specifiedType = FullType.unspecified}) =>
      object.name;

  @override
  ServerConnectStatus deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      ServerConnectStatus.valueOf(serialized as String);
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
