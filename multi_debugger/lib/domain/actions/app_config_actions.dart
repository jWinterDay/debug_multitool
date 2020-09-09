import 'package:built_redux/built_redux.dart';
import 'package:multi_debugger/domain/states/states.dart';

part 'app_config_actions.g.dart';

abstract class AppConfigActions extends ReduxActions {
  AppConfigActions._();

  factory AppConfigActions() = _$AppConfigActions;

  ActionDispatcher<LocalSettingsState> get setLocalSettings;

  ActionDispatcher<void> get fetchComputerName;
  ActionDispatcher<String> get setComputerName;

  ActionDispatcher<void> get fetchLocalSettings;
  ActionDispatcher<String> get setSavedUrls;
}
