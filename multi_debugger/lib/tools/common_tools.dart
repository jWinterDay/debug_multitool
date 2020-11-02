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

  final JsonDiffer differ = JsonDiffer.fromJson(_castJson(prev), _castJson(cur));
  return differ.diff();
}

Object _castJson(JsonObject obj) {
  if (obj == null) {
    return 'null';
  }

  if (obj.isBool) {
    return obj.asBool;
  }

  if (obj.isList) {
    return obj.asList;
  }

  if (obj.isMap) {
    return obj.asMap;
  }

  if (obj.isNum) {
    return obj.asNum;
  }

  return obj.asString;
}

String checkChannelName(String name) {
  if (name == null || name.isEmpty) {
    return 'Enter non empty name';
  }

  if (name.length > 15) {
    return 'Name length must be < 15 symbols';
  }

  return null;
}

String checkChannelShortName(String name) {
  if (name == null || name.isEmpty) {
    return 'Enter non empty short name';
  }

  if (name.length > 15) {
    return 'Short name length must be < 15 symbols';
  }

  return null;
}

String checkWsUrl(String wsUrl) {
  if (wsUrl == null || wsUrl.isEmpty) {
    return 'Enter non empty ws url';
  }

  return null;
}
