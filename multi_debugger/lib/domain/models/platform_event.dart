import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:multi_debugger/domain/enums/platform_event_type.dart';

part 'platform_event.g.dart';

abstract class PlatformEvent implements Built<PlatformEvent, PlatformEventBuilder> {
  PlatformEvent._();

  factory PlatformEvent([PlatformEventBuilder updates(PlatformEventBuilder buider)]) = _$PlatformEvent;

  @nullable
  PlatformEventType get type;

  @nullable
  int get width;

  @nullable
  int get height;

  static Serializer<PlatformEvent> get serializer => _$platformEventSerializer;
}
