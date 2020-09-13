import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:multi_debugger/domain/models/models.dart';
import 'package:uuid/uuid.dart';

part 'channel_model.g.dart';

abstract class ChannelModel implements Built<ChannelModel, ChannelModelBuilder> {
  ChannelModel._();

  factory ChannelModel([ChannelModelBuilder updates(ChannelModelBuilder builder)]) = _$ChannelModel;

  static void _initializeBuilder(ChannelModelBuilder b) => b
    ..channelId = Uuid().v4()
    ..datetime = DateTime.now().toUtc()
    ..description = ''
    ..isBlackListUsed = false
    ..isCurrent = false
    ..isWhiteListUsed = false
    ..useAutoScroll = false
    ..serverConnectStatus = ServerConnectStatus.disconnected
    ..whiteList = ListBuilder()
    ..blackList = ListBuilder()
    ..showFavoriteOnly = false;

  String get channelId;

  String get name;

  String get shortName;

  @nullable
  String get wsUrl;

  String get description;

  bool get isWhiteListUsed;

  bool get isBlackListUsed;

  bool get showFavoriteOnly;

  bool get isCurrent;

  bool get useAutoScroll;

  ServerConnectStatus get serverConnectStatus;

  DateTime get datetime;

  BuiltList<String> get whiteList;

  BuiltList<String> get blackList;

  @nullable
  ServerEvent get selectedEvent;

  static Serializer<ChannelModel> get serializer => _$channelModelSerializer;
}
