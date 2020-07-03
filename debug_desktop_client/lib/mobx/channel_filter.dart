import 'dart:convert';
import 'package:flutter/foundation.dart';

class ChannelFilter {
  ChannelFilter({
    @required this.channelFilterId,
    @required this.channelId,
    @required this.name,
    @required this.isWhite,
  });

  final int channelFilterId;
  final int channelId;
  final String name;
  final bool isWhite;

  String toJson() => json.encode(toMap());

  static ChannelFilter fromJson(String str) => fromMap(json.decode(str) as Map<String, dynamic>);

  static ChannelFilter fromMap(Map<String, dynamic> json) {
    return ChannelFilter(
      channelFilterId: int.tryParse(json['channelFilterId'].toString()),
      channelId: int.tryParse(json['channelId'].toString()),
      name: json['name'].toString(),
      isWhite: int.tryParse(json['isWhite'].toString()) == 1,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'wchannelFilterIdsUrl': channelFilterId,
      'channelId': channelId,
      'name': name,
      'isWhite': isWhite ? 1 : 0,
    };
  }
}
