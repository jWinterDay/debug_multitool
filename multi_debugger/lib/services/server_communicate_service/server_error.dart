import 'package:flutter/foundation.dart';
import 'package:multi_debugger/domain/enums/server_event_type.dart';

@immutable
class ServerError {
  const ServerError({
    @required this.message,
    @required this.serverEventType,
  })  : assert(message != null),
        assert(serverEventType != null);

  final String message;
  final ServerEventType serverEventType;
}
