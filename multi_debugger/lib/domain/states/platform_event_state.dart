import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:multi_debugger/domain/models/models.dart';

part 'platform_event_state.g.dart';

abstract class PlatformEventState implements Built<PlatformEventState, PlatformEventStateBuilder> {
  PlatformEventState._();

  factory PlatformEventState([PlatformEventStateBuilder updates(PlatformEventStateBuilder builder)]) =
      _$PlatformEventState;

  PlatformEvent get platformEvent;

  static Serializer<PlatformEventState> get serializer => _$platformEventStateSerializer;
}
