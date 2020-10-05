import 'package:built_value/built_value.dart';
import 'package:multi_debugger/domain/states/states.dart';

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
        ..platformEventState = PlatformEventState().toBuilder()
        ..userProfileState = UserProfileState().toBuilder()
        ..update(updates),
    );
  }

  AppConfigState get appConfigState;

  ChannelState get channelState;

  SavedUrlState get savedUrlState;

  ServerEventState get serverEventState;

  PlatformEventState get platformEventState;

  UserProfileState get userProfileState;

  ServerCommunicateServicesState get serverCommunicateServicesState;
}
