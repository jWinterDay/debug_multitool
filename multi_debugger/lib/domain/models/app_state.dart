import 'package:built_value/built_value.dart';
import 'package:multi_debugger/domain/models/models.dart';

part 'app_state.g.dart';

abstract class AppState implements Built<AppState, AppStateBuilder> {
  AppState._();

  factory AppState([AppStateBuilder updates(AppStateBuilder builder)]) {
    return _$AppState(
      (builder) => builder
        ..appConfigState = AppConfigState((builder) => builder).toBuilder()
        // ..channelState = ChannelState((builder) => builder).toBuilder()
        ..update(updates),
    );
  }

  ChannelState get channelState;

  AppConfigState get appConfigState;
}
