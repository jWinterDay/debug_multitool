import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:multi_debugger/domain/models/models.dart' show ServerConnectStatus;

part 'channel_model.g.dart';

abstract class ChannelModel implements Built<ChannelModel, ChannelModelBuilder> {
  ChannelModel._();

  factory ChannelModel([ChannelModelBuilder updates(ChannelModelBuilder builder)]) = _$ChannelModel;

  String get channelId;

  String get name;

  String get wsUrl;

  String get description;

  bool get isWhiteListUsed;

  bool get isBlackListUsed;

  bool get favoriteOnly;

  ServerConnectStatus get serverConnectStatus;

  DateTime get datetime;

  BuiltList<String> get whiteList;

  BuiltList<String> get blackList;

  static Serializer<ChannelModel> get serializer => _$channelModelSerializer;
}
