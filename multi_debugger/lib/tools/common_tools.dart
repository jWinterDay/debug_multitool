import 'dart:convert';

import 'package:built_value/json_object.dart';

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
