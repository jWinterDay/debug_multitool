import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'filter_list_type.g.dart';

class FilterListType extends EnumClass {
  const FilterListType._(String name) : super(name);

  static const FilterListType white = _$white;

  static const FilterListType black = _$black;

  static BuiltSet<FilterListType> get values => _$values;

  static FilterListType valueOf(String name) => _$filterListTypeValueOf(name);

  static Serializer<FilterListType> get serializer => _$filterListTypeSerializer;
}
