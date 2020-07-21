import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'centrifugo_connect_bloc.dart';

class DataSender {
  /// send data to centrifugo server
  /// example:
  /// ```json
  /// action: action1
  /// payload: {
  ///   "name1":"name1",
  ///   "name1":"name1"
  /// },
  /// state: state
  /// ```
  static Future<void> sendData({
    @required String action,
    @required Map<String, dynamic> payload,
    @required Map<String, dynamic> state,
  }) async {
    final Map<String, dynamic> dataMap = <String, dynamic>{
      'action': action,
      'payload': payload,
      'state': state,
    };

    final List<int> data = utf8.encode(jsonEncode(dataMap));

    await subscription?.publish(data);
  }
}
