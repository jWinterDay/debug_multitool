import 'package:built_redux/built_redux.dart';
import 'package:multi_debugger/domain/actions/app_config_actions.dart';
import 'package:multi_debugger/domain/actions/platform_event_actions.dart';
import 'package:multi_debugger/domain/actions/saved_url_actions.dart';
import 'package:multi_debugger/domain/actions/server_event_actions.dart';
import 'package:multi_debugger/domain/models/models.dart';

import 'channel_actions.dart';

part 'actions.g.dart';

abstract class AppActions extends ReduxActions {
  AppActions._();

  factory AppActions() = _$AppActions;

  ActionDispatcher<AppRoute> get routeTo;

  // entity's actions
  AppConfigActions get appConfigActions;

  ChannelActions get channelActions;

  SavedUrlActions get savedUrlActions;

  ServerEventActions get serverEventActions;

  PlatformEventActions get platformEventActions;
}
