import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

final DateFormat kFormatter = DateFormat('H:m:s');

class Log {
  Log({
    @required this.action,
    this.actionPayload = '',
    this.state = '',
    this.enabled = true,
  }) : _datetime = DateTime.now();

  final String action;
  final String actionPayload;
  final String state;
  final bool enabled;

  final DateTime _datetime;

  String get datetime => kFormatter.format(_datetime);
}
