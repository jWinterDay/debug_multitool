import 'package:built_redux/built_redux.dart';
import 'package:multi_debugger/domain/models/models.dart';

part 'app_config_actions.g.dart';

abstract class AppConfigActions extends ReduxActions {
  AppConfigActions._();

  factory AppConfigActions() = _$AppConfigActions;

  ActionDispatcher<LocalSettingsState> get setLocalSettings;
}
