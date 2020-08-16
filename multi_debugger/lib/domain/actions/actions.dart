import 'package:built_redux/built_redux.dart';
import 'package:multi_debugger/domain/actions/app_config_actions.dart';
import 'package:multi_debugger/domain/models/models.dart';

import 'channel_actions.dart';

part 'actions.g.dart';

abstract class AppActions extends ReduxActions {
  AppActions._();

  factory AppActions() = _$AppActions;

  ActionDispatcher<AppRoute> get routeTo;

  // entity's actions
  ChannelActions get channelActions;

  AppConfigActions get appConfigActions;
}
