import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:multi_debugger/domain/models/models.dart';

part 'channel_state.g.dart';

abstract class ChannelState implements Built<ChannelState, ChannelStateBuilder> {
  ChannelState._();

  factory ChannelState([ChannelStateBuilder updates(ChannelStateBuilder builder)]) = _$ChannelState;

  /// <channel id, model>
  BuiltMap<String, ChannelModel> get channels;

  /// current selected channel
  ChannelModel get currentChannel {
    final Iterable<ChannelModel> channelModel = channels.values.where((ChannelModel cm) {
      return cm.isCurrent;
    });

    assert(channelModel.length < 2);

    if (channelModel.isEmpty) {
      return null;
    }

    return channelModel.first;
  }

  static Serializer<ChannelState> get serializer => _$channelStateSerializer;
}
