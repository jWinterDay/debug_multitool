import 'package:built_value/built_value.dart';
import 'package:multi_debugger/domain/models/channel_state.dart';

part 'app_state.g.dart';

abstract class AppState implements Built<AppState, AppStateBuilder> {
  AppState._();

  factory AppState([dynamic updates(AppStateBuilder builder)]) {
    return _$AppState(
      (builder) => builder
        ..channelState = ChannelState((builder) => builder).toBuilder()
        ..update(updates),
    );
  }

  ChannelState get channelState;
}
