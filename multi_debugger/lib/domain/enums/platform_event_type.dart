import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'platform_event_type.g.dart';

class PlatformEventType extends EnumClass {
  const PlatformEventType._(String name) : super(name);

  static const PlatformEventType resize = _$resize;

  static const PlatformEventType close = _$close;

  static BuiltSet<PlatformEventType> get values => _$values;

  static PlatformEventType valueOf(String name) => _$platformEventTypeValueOf(name);

  static Serializer<PlatformEventType> get serializer => _$platformEventTypeSerializer;
}
