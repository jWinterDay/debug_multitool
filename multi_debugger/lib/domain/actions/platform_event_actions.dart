import 'package:built_redux/built_redux.dart';
import 'package:multi_debugger/domain/models/models.dart';

part 'platform_event_actions.g.dart';

abstract class PlatformEventActions extends ReduxActions {
  PlatformEventActions._();

  factory PlatformEventActions() = _$PlatformEventActions;

  ActionDispatcher<PlatformEvent> get addEvent;
}
