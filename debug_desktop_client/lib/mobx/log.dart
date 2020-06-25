import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

final DateFormat kFormatter = DateFormat('H:m:s');

class Log {
  Log({
    @required this.id,
    @required this.action,
    this.actionPayload = '',
    this.state = '',
    this.enabled = true,
    @required this.prevLog,
  }) : _datetime = DateTime.now();

  final int id; // List<Log> length as ID
  final String action;
  final String actionPayload;
  final String state;
  final bool enabled;
  final Log prevLog;

  final DateTime _datetime;

  String get datetime => kFormatter.format(_datetime);
}
