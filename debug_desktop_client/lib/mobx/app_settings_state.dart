import 'dart:convert';

import 'package:mobx/mobx.dart';

part 'app_settings_state.g.dart';

class AppSettingsState extends _AppSettingsState with _$AppSettingsState {
  String toJson() => json.encode(toMap());

  static _AppSettingsState fromJson(String str) => fromMap(json.decode(str) as Map<String, dynamic>);

  static AppSettingsState fromMap(Map<String, dynamic> json) {
    return AppSettingsState()..scrollToEnd = json['scrollToEnd'] == 1;
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'scrollToEnd': scrollToEnd,
    };
  }
}

abstract class _AppSettingsState with Store {
  @observable
  bool scrollToEnd = false;

  @action
  void setScrollToEnd(bool val) {
    scrollToEnd = val;
  }
}
