import 'package:flutter/foundation.dart';

@immutable
class DataBuffer {
  const DataBuffer({
    @required this.channelName,
    @required this.action,
    @required this.utf8ListData,
  }) : assert(channelName != null);

  final String channelName;
  final String action;
  final List<int> utf8ListData;
}
