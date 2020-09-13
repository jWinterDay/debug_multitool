// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payload_view_type.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const PayloadViewType _$actionPayload = const PayloadViewType._('actionPayload');
const PayloadViewType _$state = const PayloadViewType._('state');
const PayloadViewType _$diff = const PayloadViewType._('diff');

PayloadViewType _$payloadViewTypeValueOf(String name) {
  switch (name) {
    case 'actionPayload':
      return _$actionPayload;
    case 'state':
      return _$state;
    case 'diff':
      return _$diff;
    default:
      throw new ArgumentError(name);
  }
}

final BuiltSet<PayloadViewType> _$values = new BuiltSet<PayloadViewType>(const <PayloadViewType>[
  _$actionPayload,
  _$state,
  _$diff,
]);

Serializer<PayloadViewType> _$payloadViewTypeSerializer = new _$PayloadViewTypeSerializer();

class _$PayloadViewTypeSerializer implements PrimitiveSerializer<PayloadViewType> {
  @override
  final Iterable<Type> types = const <Type>[PayloadViewType];
  @override
  final String wireName = 'PayloadViewType';

  @override
  Object serialize(Serializers serializers, PayloadViewType object, {FullType specifiedType = FullType.unspecified}) =>
      object.name;

  @override
  PayloadViewType deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      PayloadViewType.valueOf(serialized as String);
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
