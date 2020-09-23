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
      b..events = BuiltMap<String, BuiltList<ServerEvent>>().toBuilder();

  /// <channel id, server event list>
  BuiltMap<String, BuiltList<ServerEvent>> get events;

  BuiltList<ServerEvent> getEventsForChannel(ChannelModel currentChannel) {
    assert(currentChannel != null);

    BuiltList<ServerEvent> list = events[currentChannel?.channelId];

    if (list == null) {
      return BuiltList();
    }

    List<ServerEvent> serverEventList = list.where((ServerEvent serverEvent) {
      // favorites
      final bool show = !currentChannel.showFavoriteOnly || serverEvent.favorite;

      return show;
    }).where((ServerEvent serverEvent) {
      // white
      final bool show = !currentChannel.isWhiteListUsed || currentChannel.whiteList.contains(serverEvent.action);

      return show;
    }).where((ServerEvent serverEvent) {
      // black
      final bool show = !currentChannel.isBlackListUsed || !currentChannel.blackList.contains(serverEvent.action);

      return show;
    }).toList();

    return BuiltList.from(serverEventList);
  }

  ServerEvent getPrevServerEvent(int index, String channelId) {
    assert(index != null);
    assert(channelId != null);

    BuiltList<ServerEvent> list = events[channelId];

    if (list == null || list.isEmpty) {
      return null;
    }

    if (index == 0) {
      return null;
    }

    return list[index - 1];
  }

  static Serializer<ServerEventState> get serializer => _$serverEventStateSerializer;
}
