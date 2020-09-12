// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'filter_list_type.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const FilterListType _$white = const FilterListType._('white');
const FilterListType _$black = const FilterListType._('black');

FilterListType _$filterListTypeValueOf(String name) {
  switch (name) {
    case 'white':
      return _$white;
    case 'black':
      return _$black;
    default:
      throw new ArgumentError(name);
  }
}

final BuiltSet<FilterListType> _$values = new BuiltSet<FilterListType>(const <FilterListType>[
  _$white,
  _$black,
]);

Serializer<FilterListType> _$filterListTypeSerializer = new _$FilterListTypeSerializer();

class _$FilterListTypeSerializer implements PrimitiveSerializer<FilterListType> {
  @override
  final Iterable<Type> types = const <Type>[FilterListType];
  @override
  final String wireName = 'FilterListType';

  @override
  Object serialize(Serializers serializers, FilterListType object, {FullType specifiedType = FullType.unspecified}) =>
      object.name;

  @override
  FilterListType deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      FilterListType.valueOf(serialized as String);
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
