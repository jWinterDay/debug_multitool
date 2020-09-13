import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'payload_view_type.g.dart';

class PayloadViewType extends EnumClass {
  const PayloadViewType._(String name) : super(name);

  static const PayloadViewType actionPayload = _$actionPayload;

  static const PayloadViewType state = _$state;

  static const PayloadViewType diff = _$diff;

  static BuiltSet<PayloadViewType> get values => _$values;

  static PayloadViewType valueOf(String name) => _$payloadViewTypeValueOf(name);

  static Serializer<PayloadViewType> get serializer => _$payloadViewTypeSerializer;
}
