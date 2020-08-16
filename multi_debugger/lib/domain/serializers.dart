import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';
import 'package:multi_debugger/domain/models/models.dart';

part 'serializers.g.dart';

@SerializersFor([
  AppState,
  ChannelState,
  AppConfigState,
  LocalSettingsState,
  ServerConnectStatus,
])
final Serializers serializers = (_$serializers.toBuilder()
      ..addPlugin(
        StandardJsonPlugin(),
      ))
    .build();
