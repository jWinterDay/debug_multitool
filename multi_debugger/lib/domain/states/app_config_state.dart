import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:multi_debugger/domain/states/states.dart';

part 'app_config_state.g.dart';

abstract class AppConfigState implements Built<AppConfigState, AppConfigStateBuilder> {
  AppConfigState._();

  factory AppConfigState([AppConfigStateBuilder updates(AppConfigStateBuilder builder)]) {
    return _$AppConfigState(
      (builder) => builder
        ..localSettings = LocalSettingsState().toBuilder()
        ..update(updates),
    );
  }

  static void _initializeBuilder(AppConfigStateBuilder b) => b..localSettings = LocalSettingsState().toBuilder();

  @nullable
  LocalSettingsState get localSettings;

  static Serializer<AppConfigState> get serializer => _$appConfigStateSerializer;
}
