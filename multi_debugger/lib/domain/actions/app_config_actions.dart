import 'package:built_redux/built_redux.dart';
import 'package:multi_debugger/domain/states/states.dart';

part 'app_config_actions.g.dart';

abstract class AppConfigActions extends ReduxActions {
  AppConfigActions._();

  factory AppConfigActions() = _$AppConfigActions;

  ActionDispatcher<LocalSettingsState> get setLocalSettings;

  // computer name
  ActionDispatcher<void> get fetchComputerName;
  ActionDispatcher<String> get setComputerName;

  // saved url list
  ActionDispatcher<void> get fetchSavedUrls;

  // saved url list
  ActionDispatcher<void> get fetchSavedChannels;
}
