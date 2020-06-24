import 'dart:convert';
import 'package:debug_desktop_client/mobx/used_url.dart';
import 'package:mobx/mobx.dart';

part 'used_url_state.g.dart';

class UsedUrlState extends _UsedUrlState with _$UsedUrlState {
  String toJson() => json.encode(toMap());

  static List<UsedUrl> fromList(List<Map<String, dynamic>> list) {
    return list.map((Map<String, dynamic> element) => UsedUrl.fromMap(element)).toList();
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'channelList': channelList.map((UsedUrl channel) => channel.toMap()).toList(),
    };
  }
}

abstract class _UsedUrlState with Store {
  @observable
  ObservableList<UsedUrl> channelList = ObservableList<UsedUrl>();
}
