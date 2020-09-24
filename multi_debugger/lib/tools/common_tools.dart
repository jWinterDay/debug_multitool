import 'dart:convert';
import 'package:json_diff/json_diff.dart';

import 'package:built_value/json_object.dart';
import 'package:multi_debugger/domain/models/models.dart';

final JsonEncoder jsonEncoder = const JsonEncoder.withIndent('   ');

String convertJsonObject(JsonObject obj) {
  if (obj.isBool) {
    return jsonEncoder.convert(obj.asBool);
  }

  if (obj.isList) {
    return jsonEncoder.convert(obj.asList);
  }

  if (obj.isMap) {
    return jsonEncoder.convert(obj.asMap);
  }

  if (obj.isNum) {
    return jsonEncoder.convert(obj.asNum);
  }

  return jsonEncoder.convert(obj.asString);
}

DiffNode getDiff(ServerEvent prevServerEvent, ServerEvent curServerEvent) {
  JsonObject prev = prevServerEvent?.state;
  JsonObject cur = curServerEvent?.state;

  final JsonDiffer differ = JsonDiffer.fromJson((prev?.asMap ?? 'null'), cur.asMap);
  return differ.diff();
}
