import 'package:built_redux/built_redux.dart';

part 'channel_actions.g.dart';

abstract class ChannelActions extends ReduxActions {
  ChannelActions._();

  factory ChannelActions() = _$ChannelActions;

  ActionDispatcher<String> get setName;
}
