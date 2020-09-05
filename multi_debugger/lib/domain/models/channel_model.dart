import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:multi_debugger/domain/models/models.dart' show ServerConnectStatus;

part 'channel_model.g.dart';

abstract class ChannelModel implements Built<ChannelModel, ChannelModelBuilder> {
  ChannelModel._();

  factory ChannelModel([ChannelModelBuilder updates(ChannelModelBuilder builder)]) = _$ChannelModel;

  static void _initializeBuilder(ChannelModelBuilder b) => b
    ..datetime = DateTime.now()
    ..description = ''
    ..isBlackListUsed = false
    ..isCurrent = false
    ..isWhiteListUsed = false
    ..serverConnectStatus = ServerConnectStatus.disconnected
    ..showFavoriteOnly = false
    ..wsUrl = '';

  String get channelId;

  String get name;

  String get wsUrl;

  String get description;

  bool get isWhiteListUsed;

  bool get isBlackListUsed;

  bool get showFavoriteOnly;

  bool get isCurrent;

  ServerConnectStatus get serverConnectStatus;

  DateTime get datetime;

  BuiltList<String> get whiteList;

  BuiltList<String> get blackList;

  static Serializer<ChannelModel> get serializer => _$channelModelSerializer;
}
