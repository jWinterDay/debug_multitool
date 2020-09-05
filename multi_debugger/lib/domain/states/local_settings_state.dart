import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:logger/logger.dart';

part 'local_settings_state.g.dart';

abstract class LocalSettingsState implements Built<LocalSettingsState, LocalSettingsStateBuilder> {
  LocalSettingsState._();

  factory LocalSettingsState([LocalSettingsStateBuilder updates(LocalSettingsStateBuilder builder)]) {
    return _$LocalSettingsState((builder) => builder
      ..enableRestLogging = false
      ..rawloggerLevel = 'error'
      ..update(updates));
  }

  static void _initializeBuilder(LocalSettingsStateBuilder b) => b
    ..enableRestLogging = false
    ..rawloggerLevel = 'error';

  @nullable
  bool get enableRestLogging;

  @BuiltValueField(wireName: 'loggerLevel')
  @nullable
  String get rawloggerLevel;

  Level get loggerLevel {
    Level level = Level.values.firstWhere(
      (Level level) => level.toString().split('.')[1] == rawloggerLevel,
      orElse: () => null,
    );

    level ??= Level.error;

    return level;
  }

  static Serializer<LocalSettingsState> get serializer => _$localSettingsStateSerializer;
}
