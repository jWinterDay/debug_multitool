import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'channel_state.g.dart';

abstract class ChannelState implements Built<ChannelState, ChannelStateBuilder> {
  ChannelState._();

  factory ChannelState([ChannelStateBuilder updates(ChannelStateBuilder builder)]) = _$ChannelState;

  // String get name;

  static Serializer<ChannelState> get serializer => _$channelStateSerializer;
}
