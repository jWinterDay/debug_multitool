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
    @required Object payload,
    @required Object state,
  }) async {
    final String output = jsonEncode(<String, dynamic>{
      'action': action,
      'payload': payload.toString(),
      'state': state.toString(),
    });

    final List<int> data = utf8.encode(output);

    await subscription?.publish(data);
  }
}
