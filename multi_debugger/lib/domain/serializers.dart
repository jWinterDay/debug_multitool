import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';
import 'package:multi_debugger/domain/models/models.dart';
import 'package:multi_debugger/domain/states/states.dart';

part 'serializers.g.dart';

@SerializersFor([
  // states
  AppState,
  ChannelState,
  AppConfigState,
  LocalSettingsState,

  // models
  ChannelModel,
  ServerConnectStatus,
  AppRoute,
])
final Serializers serializers = (_$serializers.toBuilder()
      ..addPlugin(
        StandardJsonPlugin(),
      ))
    .build();
