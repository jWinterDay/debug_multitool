import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

final DateFormat kFormatter = DateFormat('H:m:s');

@immutable
class Log {
  Log({
    this.id = 'none',
    @required this.count,
    @required this.action,
    this.actionPayload = '',
    this.state = '',
    this.enabled = true,
    @required this.prevLog,
    this.canSend = true,
    @required this.rawData,
    @required this.backAction,
  })  : assert(count != null),
        assert(action != null),
        assert(actionPayload != null),
        assert(state != null),
        assert(enabled != null),
        _datetime = DateTime.now();

  final String id;
  final int count; // List<Log> length as ID
  final String action;
  final String actionPayload;
  final String state;
  final bool enabled;
  final Log prevLog;
  final List<int> rawData;
  final bool backAction;

  /// this event can be sent back with centrifugo
  final bool canSend;
  final DateTime _datetime;

  String get datetime => kFormatter.format(_datetime);
}
