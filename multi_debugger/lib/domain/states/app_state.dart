import 'package:built_value/built_value.dart';
import 'package:multi_debugger/domain/states/app_config_state.dart';
import 'package:multi_debugger/domain/states/channel_state.dart';
import 'package:multi_debugger/domain/states/saved_url_state.dart';
import 'package:multi_debugger/domain/states/server_communicate_services_state.dart';
import 'package:multi_debugger/domain/states/server_event_state.dart';

part 'app_state.g.dart';

abstract class AppState implements Built<AppState, AppStateBuilder> {
  AppState._();

  factory AppState([AppStateBuilder updates(AppStateBuilder builder)]) {
    return _$AppState(
      (builder) => builder
        ..appConfigState = AppConfigState((builder) => builder).toBuilder()
        ..savedUrlState = SavedUrlState().toBuilder()
        ..serverCommunicateServicesState = ServerCommunicateServicesState()
        ..serverEventState = ServerEventState().toBuilder()
        ..update(updates),
    );
  }

  AppConfigState get appConfigState;

  ChannelState get channelState;

  SavedUrlState get savedUrlState;

  ServerEventState get serverEventState;

  ServerCommunicateServicesState get serverCommunicateServicesState;
}
