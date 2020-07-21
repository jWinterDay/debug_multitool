import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

final DateFormat kFormatter = DateFormat('H:m:s');

@immutable
class Log {
  Log({
    @required this.id,
    @required this.action,
    this.actionPayload = '',
    this.state = '',
    this.enabled = true,
    @required this.prevLog,
    this.canSend = true,
    @required this.rawData,
  })  : assert(id != null),
        assert(action != null),
        assert(actionPayload != null),
        assert(state != null),
        assert(enabled != null),
        _datetime = DateTime.now();

  final int id; // List<Log> length as ID
  final String action;
  final String actionPayload;
  final String state;
  final bool enabled;
  final Log prevLog;
  final List<int> rawData;

  /// this event can be sent back with centrifugo
  final bool canSend;
  final DateTime _datetime;

  String get datetime => kFormatter.format(_datetime);
}
