// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'server_event_type.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const ServerEventType _$connect = const ServerEventType._('connect');
const ServerEventType _$disconnect = const ServerEventType._('disconnect');
const ServerEventType _$action = const ServerEventType._('action');
const ServerEventType _$delimiter = const ServerEventType._('delimiter');
const ServerEventType _$formatError = const ServerEventType._('formatError');

ServerEventType _$serverEventTypeValueOf(String name) {
  switch (name) {
    case 'connect':
      return _$connect;
    case 'disconnect':
      return _$disconnect;
    case 'action':
      return _$action;
    case 'delimiter':
      return _$delimiter;
    case 'formatError':
      return _$formatError;
    default:
      throw new ArgumentError(name);
  }
}

final BuiltSet<ServerEventType> _$values = new BuiltSet<ServerEventType>(const <ServerEventType>[
  _$connect,
  _$disconnect,
  _$action,
  _$delimiter,
  _$formatError,
]);

Serializer<ServerEventType> _$serverEventTypeSerializer = new _$ServerEventTypeSerializer();

class _$ServerEventTypeSerializer implements PrimitiveSerializer<ServerEventType> {
  @override
  final Iterable<Type> types = const <Type>[ServerEventType];
  @override
  final String wireName = 'ServerEventType';

  @override
  Object serialize(Serializers serializers, ServerEventType object, {FullType specifiedType = FullType.unspecified}) =>
      object.name;

  @override
  ServerEventType deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      ServerEventType.valueOf(serialized as String);
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
