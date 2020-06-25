import 'dart:convert';
import 'package:flutter/foundation.dart';

class UsedUrl {
  UsedUrl({
    @required this.name,
    this.isPermanent = false,
    this.usedUrlId,
  })  : assert(name != null),
        assert(isPermanent != null);

  final int usedUrlId;

  final String name;

  final bool isPermanent;

  String toJson() => json.encode(toMap());

  static UsedUrl fromJson(String str) => fromMap(json.decode(str) as Map<String, dynamic>);

  static UsedUrl fromMap(Map<String, dynamic> json) {
    return UsedUrl(
      usedUrlId: json['usedUrlId'],
      name: json['name'],
      isPermanent: json['isPermanent'] == 1,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'usedUrlId': usedUrlId,
      'name': name,
      'isPermanent': isPermanent,
    };
  }
}
