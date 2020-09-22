import 'package:built_collection/built_collection.dart';
import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';
import 'package:multi_debugger/domain/enums/filter_list_type.dart';
import 'package:multi_debugger/domain/enums/payload_view_type.dart';
import 'package:multi_debugger/domain/enums/platform_event_type.dart';
import 'package:multi_debugger/domain/models/models.dart';
import 'package:multi_debugger/domain/enums/server_event_type.dart';
import 'package:multi_debugger/domain/states/platform_event_state.dart';
import 'package:multi_debugger/domain/states/states.dart';

part 'serializers.g.dart';

@SerializersFor([
  // states
  AppState,
  ChannelState,
  AppConfigState,
  LocalSettingsState,
  SavedUrlState,
  SavedUrl,
  PlatformEventState,

  // models
  ChannelModel,
  ServerConnectStatus,
  AppRoute,
  ServerEvent,
  PlatformEvent,

  // enums
  FilterListType,
  PlatformEventType,
  PayloadViewType,
  ServerEventType,
])
final Serializers serializers = (_$serializers.toBuilder()
      ..addBuilderFactory(
        const FullType(BuiltList, [FullType(String)]),
        () => ListBuilder<String>(),
      )
      ..addPlugin(
        StandardJsonPlugin(),
      ))
    .build();
