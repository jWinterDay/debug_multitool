// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'platform_event_type.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const PlatformEventType _$resize = const PlatformEventType._('resize');
const PlatformEventType _$close = const PlatformEventType._('close');

PlatformEventType _$platformEventTypeValueOf(String name) {
  switch (name) {
    case 'resize':
      return _$resize;
    case 'close':
      return _$close;
    default:
      throw new ArgumentError(name);
  }
}

final BuiltSet<PlatformEventType> _$values = new BuiltSet<PlatformEventType>(const <PlatformEventType>[
  _$resize,
  _$close,
]);

Serializer<PlatformEventType> _$platformEventTypeSerializer = new _$PlatformEventTypeSerializer();

class _$PlatformEventTypeSerializer implements PrimitiveSerializer<PlatformEventType> {
  @override
  final Iterable<Type> types = const <Type>[PlatformEventType];
  @override
  final String wireName = 'PlatformEventType';

  @override
  Object serialize(Serializers serializers, PlatformEventType object,
          {FullType specifiedType = FullType.unspecified}) =>
      object.name;

  @override
  PlatformEventType deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      PlatformEventType.valueOf(serialized as String);
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
