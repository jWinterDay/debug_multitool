import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:multi_debugger/domain/models/models.dart';

part 'server_event_state.g.dart';

abstract class ServerEventState implements Built<ServerEventState, ServerEventStateBuilder> {
  ServerEventState._();

  factory ServerEventState([
    ServerEventStateBuilder updates(ServerEventStateBuilder builder),
  ]) = _$ServerEventState;

  static void _initializeBuilder(ServerEventStateBuilder b) =>
      b..events = BuiltMap<String, List<ServerEvent>>().toBuilder();

  /// <channel id, url>
  BuiltMap<String, List<ServerEvent>> get events;

  List<ServerEvent> getEventsForChannel(String channelName) {
    return events[channelName];
  }

  static Serializer<ServerEventState> get serializer => _$serverEventStateSerializer;
}
