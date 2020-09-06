import 'package:built_redux/built_redux.dart';
import 'package:multi_debugger/domain/actions/app_config_actions.dart';
import 'package:multi_debugger/domain/states/states.dart';

NestedReducerBuilder<AppState, AppStateBuilder, AppConfigState, AppConfigStateBuilder> createConfigReducer() {
  return NestedReducerBuilder<AppState, AppStateBuilder, AppConfigState, AppConfigStateBuilder>(
    (state) => state.appConfigState,
    (builder) => builder.appConfigState,
  )
    ..add<LocalSettingsState>(AppConfigActionsNames.setLocalSettings, _setLocalSettings)
    ..add<String>(AppConfigActionsNames.setComputerName, _setComputerName);
}

void _setLocalSettings(AppConfigState state, Action<LocalSettingsState> action, AppConfigStateBuilder builder) {
  builder.localSettings.replace(action.payload);
}

void _setComputerName(AppConfigState state, Action<String> action, AppConfigStateBuilder builder) {
  builder.computerName = action.payload;
}
