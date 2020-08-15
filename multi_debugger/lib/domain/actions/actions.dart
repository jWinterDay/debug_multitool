import 'package:built_redux/built_redux.dart';

import 'channel_actions.dart';

part 'actions.g.dart';

abstract class AppActions extends ReduxActions {
  AppActions._();

  factory AppActions() = _$AppActions;

  ChannelActions get channelActions;
}
