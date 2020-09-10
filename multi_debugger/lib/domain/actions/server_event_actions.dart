import 'package:built_redux/built_redux.dart';
import 'package:multi_debugger/domain/base/pair.dart';
import 'package:multi_debugger/domain/models/models.dart';

part 'server_event_actions.g.dart';

abstract class ServerEventActions extends ReduxActions {
  ServerEventActions._();

  factory ServerEventActions() = _$ServerEventActions;

  /// <channel id, add server event>
  ActionDispatcher<Pair<String, ServerEvent>> get addEvent;

  ActionDispatcher<Pair<String, ServerEvent>> get toggleFavorite;
}
